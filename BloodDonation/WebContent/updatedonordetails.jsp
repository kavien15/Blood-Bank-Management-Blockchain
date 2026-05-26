<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.math.BigInteger" %>



<%@ page import="com.amazonaws.auth.AWSStaticCredentialsProvider" %>
<%@ page import="com.amazonaws.auth.BasicAWSCredentials" %>
<%@ page import="com.amazonaws.client.builder.AwsClientBuilder" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3ClientBuilder" %>
<%@ page import="com.amazonaws.services.s3.model.ObjectMetadata" %>
<%@ page import="com.amazonaws.services.s3.model.PutObjectRequest" %>


<%@ page import="org.web3j.protocol.Web3j" %>
<%@ page import="org.web3j.protocol.http.HttpService" %>
<%@ page import="org.web3j.crypto.Credentials" %>
<%@ page import="org.web3j.crypto.RawTransaction" %>
<%@ page import="org.web3j.crypto.TransactionEncoder" %>
<%@ page import="org.web3j.protocol.core.methods.response.EthSendTransaction" %>
<%@ page import="org.web3j.protocol.core.DefaultBlockParameterName" %>
<%@ page import="org.web3j.utils.Numeric" %>

<%@ page import="dbcon.Dbcon" %>

<%
   
    final String FILEBASE_KEY = "9AED1223862989DD6BE1";
    final String FILEBASE_SECRET = "5mxSXGVbqHbTYtTgzxari6hvXf34e0I026MaN0yH";
    final String FILEBASE_S3_ENDPOINT = "https://s3.filebase.com";
    final String FILEBASE_BUCKET = "blockchainprismkyc";

    final String GANACHE_URL = "http://192.168.1.35:7545";
    final String PRIVATE_KEY = "0x71697d73239fd0863a8cf3879f3912414d6d3918e56cd18cd013aee9e22f1c3e";


    String pname = request.getParameter("pname");
    String hname = request.getParameter("hname");
    String bg = request.getParameter("bg");
    String bp = request.getParameter("bp");
    String email = request.getParameter("email");
    String number = request.getParameter("number");
    String bdate = request.getParameter("bdate");
    String adate = request.getParameter("adate");
    String status = request.getParameter("status");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    int insertedId = -1;

    try {

  
        con = Dbcon.create();
        ps = con.prepareStatement(
            "INSERT INTO blood.donatedetails VALUES(id,?,?,?,?,?,?,?,?,?,?,?,?)",
            Statement.RETURN_GENERATED_KEYS);

        ps.setString(1, pname);
        ps.setString(2, hname);
        ps.setString(3, bg);
        ps.setString(4, bp);
        ps.setString(5, email);
        ps.setString(6, number);
        ps.setString(7, bdate);
        ps.setString(8, adate);
        ps.setString(9, status);
        ps.setString(10, ""); 
        ps.setString(11, ""); 
        ps.setString(12, ""); 
      

        ps.executeUpdate();

        rs = ps.getGeneratedKeys();
        if (rs.next()) {
            insertedId = rs.getInt(1);
        }

        rs.close();
        ps.close();

        if (insertedId == -1) {
            response.sendRedirect("error.jsp?msg=InsertFailed");
            return;
        }



        JSONObject obj = new JSONObject();
        obj.put("id", insertedId);
        obj.put("patient_name", pname);
        obj.put("hospital_name", hname);
        obj.put("blood_group", bg);
        obj.put("type", bp);
        obj.put("email", email);
        obj.put("phone", number);
        obj.put("before_date", bdate);
        obj.put("after_date", adate);
        obj.put("status", status);

        String jsonString = obj.toString();


     
        BasicAWSCredentials awsCreds = new BasicAWSCredentials(FILEBASE_KEY, FILEBASE_SECRET);
        AwsClientBuilder.EndpointConfiguration endpoint =
            new AwsClientBuilder.EndpointConfiguration(FILEBASE_S3_ENDPOINT, "us-east-1");

        AmazonS3 s3 = AmazonS3ClientBuilder.standard()
                    .withEndpointConfiguration(endpoint)
                    .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                    .withPathStyleAccessEnabled(true)
                    .build();

        String objectKey = "blood_" + insertedId + ".json";
        byte[] jsonBytes = jsonString.getBytes("UTF-8");
        InputStream inputStream = new ByteArrayInputStream(jsonBytes);

        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentType("application/json");
        metadata.setContentLength(jsonBytes.length);

        s3.putObject(new PutObjectRequest(FILEBASE_BUCKET, objectKey, inputStream, metadata));

 
        String cid = null;
        try {
            ObjectMetadata meta = s3.getObjectMetadata(FILEBASE_BUCKET, objectKey);
            cid = meta.getUserMetaDataOf("ipfs-hash");
            if (cid == null) cid = meta.getUserMetaDataOf("cid");
            if (cid == null) cid = objectKey;
        } catch(Exception e) {
            cid = objectKey;
        }


       
        Web3j web3 = Web3j.build(new HttpService(GANACHE_URL));
        Credentials creds = Credentials.create(PRIVATE_KEY);
        String senderAddress = creds.getAddress();

        BigInteger nonce = web3.ethGetTransactionCount(senderAddress, DefaultBlockParameterName.PENDING)
                          .send().getTransactionCount();

        BigInteger gasPrice = web3.ethGasPrice().send().getGasPrice();
        BigInteger gasLimit = BigInteger.valueOf(300_000);

        byte[] cidBytes = cid.getBytes("UTF-8");
        String cidHex = Numeric.toHexString(cidBytes);

        RawTransaction rawTx = RawTransaction.createTransaction(
            nonce, gasPrice, gasLimit, senderAddress, BigInteger.ZERO, cidHex);

        byte[] signedMsg = TransactionEncoder.signMessage(rawTx, creds);
        String hexVal = Numeric.toHexString(signedMsg);

        EthSendTransaction txResponse = web3.ethSendRawTransaction(hexVal).send();

        String txHash = txResponse.getTransactionHash();


       
        ps = con.prepareStatement("UPDATE blood.donatedetails SET cid=?, txhash=?, sender_addr=? WHERE id=?");
        ps.setString(1, cid);
        ps.setString(2, txHash);
        ps.setString(3, senderAddress);
        ps.setInt(4, insertedId);
        ps.executeUpdate();
        ps.close();


    
        Statement st = con.createStatement();
        st.executeUpdate("UPDATE blood.patient SET status='" + status + "', email='" + email + "' WHERE status='allocate' ");
        st.executeUpdate("UPDATE blood.donorlist SET status='" + status + "' WHERE donor_email='" + email + "' ");

        response.sendRedirect("donorhome.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp?msg=Exception");
    }
%>

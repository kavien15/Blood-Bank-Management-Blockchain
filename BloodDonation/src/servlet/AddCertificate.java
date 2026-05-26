/* package servlet;

import java.io.IOException;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONObject;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.*;
import com.amazonaws.services.s3.model.*;

import org.web3j.crypto.*;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;
import org.web3j.utils.Numeric;

import java.math.BigInteger;

import dbcon.Dbcon;

@WebServlet("/AddCertificate")
public class AddCertificate extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dname = request.getParameter("dname");
        String dmail = request.getParameter("dmail");
        String dnumber = request.getParameter("dnumber");
        String hname = request.getParameter("hname");
        String hmail = request.getParameter("hmail");
        String hnumber = request.getParameter("hnumber");
        String date = request.getParameter("date"); 

       
        final String FILEBASE_KEY = "9AED1223862989DD6BE1";
        final String FILEBASE_SECRET = "5mxSXGVbqHbTYtTgzxari6hvXf34e0I026MaN0yH";
        final String FILEBASE_BUCKET = "blockchainprismkyc";
        final String FILEBASE_ENDPOINT = "https://s3.filebase.com";

        
        final String GANACHE_URL = "http://192.168.1.47:7545";
        final String PRIVATE_KEY = "0x2abce367941f1cedc3dba8f8f955a85825a100af2a7facf7d8269d89f2c0ab0e";

        try {

            Connection con = Dbcon.create();

           
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO blood.certificate VALUES(id,?,?,?,?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, dname);
            ps.setString(2, dmail);
            ps.setString(3, dnumber);
            ps.setString(4, hname);
            ps.setString(5, hmail);
            ps.setString(6, hnumber);
            ps.setString(7, date);

            int reg = ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int certificateId = (rs.next()) ? rs.getInt(1) : -1;
            rs.close();
            ps.close();

            if (reg != 1 || certificateId == -1) {
                response.sendRedirect("error.jsp");
                return;
            }

           
            PreparedStatement ps2 = con.prepareStatement(
                    "SELECT * FROM donorlist WHERE donor_email=?");
            ps2.setString(1, dmail);

            ResultSet donorRS = ps2.executeQuery();

            if (!donorRS.next()) {
                response.sendRedirect("error.jsp?msg=DonorNotFound");
                return;
            }

            String bloodGroup = donorRS.getString(5);
            donorRS.close();
            ps2.close();

           

            String inputDate = date; 

            SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat outFormat = new SimpleDateFormat("dd-MM-yyyy");

            java.util.Date parsedDate = dbFormat.parse(inputDate);

            Calendar cal = Calendar.getInstance();
            cal.setTime(parsedDate);

            
            cal.add(Calendar.MONTH, 3);

           
            String afterDate = outFormat.format(cal.getTime());

            
            PreparedStatement ps3 = con.prepareStatement(
                    "INSERT INTO blood.donatedetails VALUES(id,?,?,?,?,?,?,?,?,?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);

            ps3.setString(1, "Donated In Camp");
            ps3.setString(2, hname);
            ps3.setString(3, bloodGroup);
            ps3.setString(4, "blood");
            ps3.setString(5, dmail);
            ps3.setString(6, dnumber);
            ps3.setString(7, outFormat.format(parsedDate)); 
            ps3.setString(8, afterDate);                  
            ps3.setString(9, "donated");
            ps3.setString(10, "");
            ps3.setString(11, "");
            ps3.setString(12, "");

            ps3.executeUpdate();

            ResultSet rs3 = ps3.getGeneratedKeys();
            int donationId = (rs3.next()) ? rs3.getInt(1) : -1;
            rs3.close();
            ps3.close();

            if (donationId == -1) {
                response.sendRedirect("error.jsp?msg=DonationInsertFailed");
                return;
            }

            
            JSONObject obj = new JSONObject();
            obj.put("certificate_id", certificateId);
            obj.put("donation_id", donationId);
            obj.put("donor_name", dname);
            obj.put("hospital_name", hname);
            obj.put("blood_group", bloodGroup);
            obj.put("date", outFormat.format(parsedDate));
            obj.put("next_donation", afterDate);

            byte[] jsonBytes = obj.toString().getBytes("UTF-8");

            
            BasicAWSCredentials creds = new BasicAWSCredentials(FILEBASE_KEY, FILEBASE_SECRET);
            AmazonS3 s3 = AmazonS3ClientBuilder.standard()
                    .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(FILEBASE_ENDPOINT, "us-east-1"))
                    .withCredentials(new AWSStaticCredentialsProvider(creds))
                    .withPathStyleAccessEnabled(true)
                    .build();

            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType("application/json");
            metadata.setContentLength(jsonBytes.length);

            String objectKey = "blood_" + donationId + ".json";

            InputStream is = new ByteArrayInputStream(jsonBytes);

            s3.putObject(new PutObjectRequest(FILEBASE_BUCKET, objectKey, is, metadata));

            String cid = objectKey;

            try {
                ObjectMetadata meta = s3.getObjectMetadata(FILEBASE_BUCKET, objectKey);
                if (meta.getUserMetaDataOf("cid") != null)
                    cid = meta.getUserMetaDataOf("cid");
            } catch (Exception ex) {}

           
            Web3j web3 = Web3j.build(new HttpService(GANACHE_URL));

            Credentials wallet = Credentials.create(PRIVATE_KEY);
            String senderAddress = wallet.getAddress();

            BigInteger nonce = web3.ethGetTransactionCount(senderAddress,
                    org.web3j.protocol.core.DefaultBlockParameterName.LATEST)
                    .send().getTransactionCount();

            BigInteger gasPrice = web3.ethGasPrice().send().getGasPrice();
            BigInteger gasLimit = BigInteger.valueOf(300000);

            String cidHex = Numeric.toHexString(cid.getBytes("UTF-8"));

            RawTransaction tx = RawTransaction.createTransaction(
                    nonce, gasPrice, gasLimit, senderAddress, BigInteger.ZERO, cidHex);

            byte[] signed = TransactionEncoder.signMessage(tx, wallet);
            String txHash = web3.ethSendRawTransaction(Numeric.toHexString(signed)).send().getTransactionHash();

            PreparedStatement psUpdate = con.prepareStatement(
                    "UPDATE blood.donatedetails SET cid=?, txhash=?, sender_addr=? WHERE id=?");
            psUpdate.setString(1, cid);
            psUpdate.setString(2, txHash);
            psUpdate.setString(3, senderAddress);
            psUpdate.setInt(4, donationId);
            psUpdate.executeUpdate();
            psUpdate.close();

            
            PreparedStatement ps4 = con.prepareStatement(
                    "UPDATE blood.campdonate SET status='certificated' WHERE donormail=?");
            ps4.setString(1, dmail);
            ps4.executeUpdate();
            ps4.close();

            response.sendRedirect("addcertificate.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Exception");
        }
    }
} */




package servlet;

import java.io.IOException;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONObject;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.*;
import com.amazonaws.services.s3.model.*;

import org.web3j.crypto.*;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;
import org.web3j.utils.Numeric;

import java.math.BigInteger;

import dbcon.Dbcon;

@WebServlet("/AddCertificate")
public class AddCertificate extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dname = request.getParameter("dname");
        String dmail = request.getParameter("dmail");
        String dnumber = request.getParameter("dnumber");
        String hname = request.getParameter("hname");
        String hmail = request.getParameter("hmail");
        String hnumber = request.getParameter("hnumber");
        String date = request.getParameter("date");

        final String FILEBASE_KEY = "9AED1223862989DD6BE1";
        final String FILEBASE_SECRET = "5mxSXGVbqHbTYtTgzxari6hvXf34e0I026MaN0yH";
        final String FILEBASE_BUCKET = "blockchainprismkyc";
        final String FILEBASE_ENDPOINT = "https://s3.filebase.com";

        final String GANACHE_URL = "http://192.168.1.47:7545";
        final String PRIVATE_KEY = "0x2abce367941f1cedc3dba8f8f955a85825a100af2a7facf7d8269d89f2c0ab0e";

        try {

            Connection con = Dbcon.create();

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO blood.certificate VALUES(id,?,?,?,?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, dname);
            ps.setString(2, dmail);
            ps.setString(3, dnumber);
            ps.setString(4, hname);
            ps.setString(5, hmail);
            ps.setString(6, hnumber);
            ps.setString(7, date);

            int reg = ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int certificateId = (rs.next()) ? rs.getInt(1) : -1;
            rs.close();
            ps.close();

            if (reg != 1 || certificateId == -1) {
                response.sendRedirect("error.jsp");
                return;
            }

            PreparedStatement ps2 = con.prepareStatement(
                    "SELECT * FROM donorlist WHERE donor_email=?");
            ps2.setString(1, dmail);

            ResultSet donorRS = ps2.executeQuery();

            if (!donorRS.next()) {
                response.sendRedirect("error.jsp?msg=DonorNotFound");
                return;
            }

            String bloodGroup = donorRS.getString(5);
            donorRS.close();
            ps2.close();

            SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat outFormat = new SimpleDateFormat("dd-MM-yyyy");

            java.util.Date parsedDate = dbFormat.parse(date);

            Calendar cal = Calendar.getInstance();
            cal.setTime(parsedDate);
            cal.add(Calendar.MONTH, 3);

            String afterDate = outFormat.format(cal.getTime());

            PreparedStatement ps3 = con.prepareStatement(
                    "INSERT INTO blood.donatedetails VALUES(id,?,?,?,?,?,?,?,?,?,?,?,?)",
                    Statement.RETURN_GENERATED_KEYS);

            ps3.setString(1, "Donated In Camp");
            ps3.setString(2, hname);
            ps3.setString(3, bloodGroup);
            ps3.setString(4, "blood");
            ps3.setString(5, dmail);
            ps3.setString(6, dnumber);
            ps3.setString(7, outFormat.format(parsedDate));
            ps3.setString(8, afterDate);
            ps3.setString(9, "donated");
            ps3.setString(10, "");
            ps3.setString(11, "");
            ps3.setString(12, "");

            ps3.executeUpdate();

            ResultSet rs3 = ps3.getGeneratedKeys();
            int donationId = (rs3.next()) ? rs3.getInt(1) : -1;
            rs3.close();
            ps3.close();

            if (donationId == -1) {
                response.sendRedirect("error.jsp?msg=DonationInsertFailed");
                return;
            }

            JSONObject obj = new JSONObject();
            obj.put("certificate_id", certificateId);
            obj.put("donation_id", donationId);
            obj.put("donor_name", dname);
            obj.put("hospital_name", hname);
            obj.put("blood_group", bloodGroup);
            obj.put("date", outFormat.format(parsedDate));
            obj.put("next_donation", afterDate);

            byte[] jsonBytes = obj.toString().getBytes("UTF-8");

            /* ================= ASCON ENCRYPTION (ONLY ADDITION) ================= */

            Ascon ascon = new Ascon();
            byte[] key = ascon.generateKey();
            byte[] nonce = ascon.generateNonce();
            byte[] encryptedJson = ascon.encrypt(key, nonce, jsonBytes);

            /* =================================================================== */

            BasicAWSCredentials creds = new BasicAWSCredentials(FILEBASE_KEY, FILEBASE_SECRET);
            AmazonS3 s3 = AmazonS3ClientBuilder.standard()
                    .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(FILEBASE_ENDPOINT, "us-east-1"))
                    .withCredentials(new AWSStaticCredentialsProvider(creds))
                    .withPathStyleAccessEnabled(true)
                    .build();

            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType("application/octet-stream");
            metadata.setContentLength(encryptedJson.length);

            String objectKey = "blood_" + donationId + ".json";

            InputStream is = new ByteArrayInputStream(encryptedJson);
            s3.putObject(new PutObjectRequest(FILEBASE_BUCKET, objectKey, is, metadata));

            String cid = objectKey;

            Web3j web3 = Web3j.build(new HttpService(GANACHE_URL));
            Credentials wallet = Credentials.create(PRIVATE_KEY);
            String senderAddress = wallet.getAddress();

            BigInteger nonceEth = web3.ethGetTransactionCount(
                    senderAddress,
                    org.web3j.protocol.core.DefaultBlockParameterName.LATEST)
                    .send().getTransactionCount();

            BigInteger gasPrice = web3.ethGasPrice().send().getGasPrice();
            BigInteger gasLimit = BigInteger.valueOf(300000);

            String cidHex = Numeric.toHexString(cid.getBytes("UTF-8"));

            RawTransaction tx = RawTransaction.createTransaction(
                    nonceEth, gasPrice, gasLimit, senderAddress, BigInteger.ZERO, cidHex);

            byte[] signed = TransactionEncoder.signMessage(tx, wallet);
            String txHash = web3.ethSendRawTransaction(
                    Numeric.toHexString(signed)).send().getTransactionHash();

            PreparedStatement psUpdate = con.prepareStatement(
                    "UPDATE blood.donatedetails SET cid=?, txhash=?, sender_addr=? WHERE id=?");
            psUpdate.setString(1, cid);
            psUpdate.setString(2, txHash);
            psUpdate.setString(3, senderAddress);
            psUpdate.setInt(4, donationId);
            psUpdate.executeUpdate();
            psUpdate.close();

            PreparedStatement ps4 = con.prepareStatement(
                    "UPDATE blood.campdonate SET status='certificated' WHERE donormail=?");
            ps4.setString(1, dmail);
            ps4.executeUpdate();
            ps4.close();

            response.sendRedirect("addcertificate.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Exception");
        }
    }
}


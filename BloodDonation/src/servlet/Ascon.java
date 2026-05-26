package servlet;


import java.security.SecureRandom;

import org.bouncycastle.crypto.CipherParameters;
import org.bouncycastle.crypto.InvalidCipherTextException;
import org.bouncycastle.crypto.engines.AsconEngine;
import org.bouncycastle.crypto.modes.AEADCipher;
import org.bouncycastle.crypto.params.AEADParameters;
import org.bouncycastle.crypto.params.KeyParameter;

public class Ascon {

    private static final int KEY_SIZE = 16;   
    private static final int NONCE_SIZE = 16;  
    private static final int MAC_SIZE = 128; 

    private final SecureRandom random = new SecureRandom();

    
    public byte[] generateKey() {
        byte[] key = new byte[KEY_SIZE];
        random.nextBytes(key);
        return key;
    }

   
    public byte[] generateNonce() {
        byte[] nonce = new byte[NONCE_SIZE];
        random.nextBytes(nonce);
        return nonce;
    }

   
    public byte[] encrypt(byte[] key, byte[] nonce, byte[] plaintext) throws InvalidCipherTextException {
        AEADCipher cipher = new AsconEngine(AsconEngine.AsconParameters.ascon128); 
        CipherParameters params = new AEADParameters(new KeyParameter(key), MAC_SIZE, nonce, null);

        cipher.init(true, params);

        byte[] out = new byte[cipher.getOutputSize(plaintext.length)];
        int len = cipher.processBytes(plaintext, 0, plaintext.length, out, 0);
        cipher.doFinal(out, len);

        return out;
    }

   
    public byte[] decrypt(byte[] key, byte[] nonce, byte[] ciphertext) throws InvalidCipherTextException {
        AEADCipher cipher = new AsconEngine(AsconEngine.AsconParameters.ascon128);
        CipherParameters params = new AEADParameters(new KeyParameter(key), MAC_SIZE, nonce, null);

        cipher.init(false, params);

        byte[] out = new byte[cipher.getOutputSize(ciphertext.length)];
        int len = cipher.processBytes(ciphertext, 0, ciphertext.length, out, 0);
        cipher.doFinal(out, len);

        return out;
    }


    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder(bytes.length * 2);
        for (byte b : bytes) sb.append(String.format("%02X", b));
        return sb.toString();
    }
}

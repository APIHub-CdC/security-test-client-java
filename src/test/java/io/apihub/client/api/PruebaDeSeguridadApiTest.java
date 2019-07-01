package io.apihub.client.api;

import io.apihub.client.ApiClient;
import io.apihub.client.ApiException;
import io.apihub.interceptor.SignerInterceptor;
import okhttp3.OkHttpClient;

import java.util.concurrent.TimeUnit;

import org.junit.Before;
import org.junit.Test;


public class PruebaDeSeguridadApiTest {

    private final PruebaDeSeguridadApi api = new PruebaDeSeguridadApi();
    private ApiClient apiClient;
    
    @Before()
    public void setUp() {
    	this.apiClient = api.getApiClient();
		OkHttpClient okHttpClient = new OkHttpClient().newBuilder()
				.readTimeout(30, TimeUnit.SECONDS)
				.addInterceptor(new SignerInterceptor())
				.build();
		apiClient.setHttpClient(okHttpClient);
    }

    @Test
    public void securityTestTest() throws ApiException {
        String xApiKey = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        String body = "Esto es un mensaje de prueba";
        String response = api.securityTest(xApiKey, body);
        System.out.println(response);
    }
    
}

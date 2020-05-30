package io.codesquad.group6.mockbnb.githuboauth;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.Objects;

@Service
@Slf4j
public class OAuthService {

    private final ObjectMapper objectMapper;

    private final String AUTHORIZE_URL = "https://github.com/login/oauth/authorize";
    private final String ACCESS_TOKEN_URL = "https://github.com/login/oauth/access_token";
    private final String USER_DATA_API = "https://api.github.com/user";
    private final String CLIENT_ID;
    private final String CLIENT_SECRET;

    public OAuthService(Environment env, ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
        CLIENT_ID = env.getProperty("github.client_id");
        CLIENT_SECRET = env.getProperty("github.client_secret");
    }

    public void redirectToGitHubAuthorization(HttpServletResponse response) throws IOException {
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(AUTHORIZE_URL)
                                                           .queryParam("client_id", CLIENT_ID);
        response.sendRedirect(builder.toUriString());
    }

    public GitHubUserData getGitHubUserData(String code) throws JsonProcessingException {
        String accessToken = getAccessToken(code);
        ResponseEntity<String> response = new RestTemplate().exchange(USER_DATA_API,
                                                                      HttpMethod.GET,
                                                                      getHttpEntityWithAuthorization(accessToken),
                                                                      String.class);
        JsonNode jsonNode = objectMapper.readTree(response.getBody());
        return GitHubUserData.builder()
                             .id(jsonNode.required("id").asLong())
                             .login(jsonNode.required("login").asText())
                             .email(jsonNode.required("email").asText())
                             .build();
    }

    private String getAccessToken(String code) {
        AccessTokenData accessTokenData = new RestTemplate().postForEntity(getUrlForAccessToken(code),
                                                                           getHttpEntityWithSetAcceptJson(),
                                                                           AccessTokenData.class)
                                                            .getBody();
        return Objects.requireNonNull(accessTokenData).getAccessToken();
    }

    private String getUrlForAccessToken(String code) {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("client_id", CLIENT_ID);
        params.add("client_secret", CLIENT_SECRET);
        params.add("code", code);
        return UriComponentsBuilder.fromHttpUrl(ACCESS_TOKEN_URL)
                                   .queryParams(params)
                                   .toUriString();
    }

    private HttpEntity<String> getHttpEntityWithSetAcceptJson() {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        return new HttpEntity<>(headers);
    }

    private HttpEntity<String> getHttpEntityWithAuthorization(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        return new HttpEntity<>(headers);
    }

}

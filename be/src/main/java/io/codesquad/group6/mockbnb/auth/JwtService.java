package io.codesquad.group6.mockbnb.auth;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
public class JwtService {

    private final Key key;

    public JwtService() {
        key = Keys.secretKeyFor(SignatureAlgorithm.HS256);
    }

    public String buildJwt(GitHubUserData gitHubUserData) {
        return Jwts.builder()
                   .setHeader(createHeaders())
                   .setClaims(createClaims(gitHubUserData))
                   .signWith(key, SignatureAlgorithm.HS256)
                   .compact();
    }

    public GitHubUserData parseJwt(String jwt) {
        Claims claims = Jwts.parserBuilder()
                            .setSigningKey(key)
                            .build()
                            .parseClaimsJws(jwt)
                            .getBody();
        String login = (String) claims.get("login");
        String email = (String) claims.get("email");
        return GitHubUserData.builder()
                             .login(login)
                             .email(email)
                             .build();
    }

    private Map<String, Object> createHeaders() {
        Map<String, Object> headers = new HashMap<>();
        headers.put("typ", "JWT");
        headers.put("alg", "HS256");
        return headers;
    }

    private Map<String, Object> createClaims(GitHubUserData gitHubUserData) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("login", gitHubUserData.getLogin());
        claims.put("email", gitHubUserData.getEmail());
        return claims;
    }

}

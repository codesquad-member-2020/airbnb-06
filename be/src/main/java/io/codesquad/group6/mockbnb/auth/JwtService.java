package io.codesquad.group6.mockbnb.auth;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@Service
@Slf4j
public class JwtService {

    private final SecretKey key;

    public JwtService(Environment env) {
        key = Keys.hmacShaKeyFor(Objects.requireNonNull(env.getProperty("jwt.secret"))
                                        .getBytes(StandardCharsets.UTF_8));
    }

    public String buildJwt(GitHubUserData gitHubUserData) {
        return Jwts.builder()
                   .setHeader(createHeaders())
                   .setClaims(createClaims(gitHubUserData))
                   .signWith(key, SignatureAlgorithm.HS256)
                   .compact();
    }

    public GitHubUserData parseJwt(String jwt) {
        jwt = jwt.replace("Bearer ", "");
        Claims claims = Jwts.parserBuilder()
                            .setSigningKey(key)
                            .build()
                            .parseClaimsJws(jwt)
                            .getBody();
        long id = Integer.toUnsignedLong((int) claims.get("id"));
        String login = (String) claims.get("login");
        String email = (String) claims.get("email");
        return GitHubUserData.builder()
                             .id(id)
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
        claims.put("id", gitHubUserData.getId());
        claims.put("login", gitHubUserData.getLogin());
        claims.put("email", gitHubUserData.getEmail());
        return claims;
    }

}

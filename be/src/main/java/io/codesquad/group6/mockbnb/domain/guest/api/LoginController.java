package io.codesquad.group6.mockbnb.domain.guest.api;

import io.codesquad.group6.mockbnb.githuboauth.GitHubUserData;
import io.codesquad.group6.mockbnb.githuboauth.JwtService;
import io.codesquad.group6.mockbnb.githuboauth.OAuthService;
import io.codesquad.group6.mockbnb.domain.guest.domain.GuestService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
public class LoginController {

    private final OAuthService oAuthService;
    private final JwtService jwtService;
    private final GuestService guestService;

    public LoginController(OAuthService oAuthService, JwtService jwtService, GuestService guestService) {
        this.oAuthService = oAuthService;
        this.jwtService = jwtService;
        this.guestService = guestService;
    }

    @GetMapping("/login")
    public void login(HttpServletResponse response) throws IOException {
        oAuthService.redirectToGitHubAuthorization(response);
    }

    @GetMapping("/oauth")
    public void oauth(@RequestParam String code, HttpServletResponse response) throws IOException {
        GitHubUserData gitHubUserData = oAuthService.getGitHubUserData(code);
        guestService.insertOrUpdateOnDuplicateKey(gitHubUserData);
        String jwt = jwtService.buildJwt(gitHubUserData);
        // response.addCookie(new Cookie("token", jwt));
        // response.sendRedirect("http://localhost:8080/");
        response.sendRedirect("io.airbnb.app:/oauth?token=" + jwt);
    }

}

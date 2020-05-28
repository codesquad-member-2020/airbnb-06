package io.codesquad.group6.mockbnb.auth;

import io.codesquad.group6.mockbnb.domain.guest.GuestService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Service
@Slf4j
public class JwtInterceptor implements HandlerInterceptor {

    private final JwtService jwtService;
    private final GuestService guestService;

    public JwtInterceptor(JwtService jwtService, GuestService guestService) {
        this.jwtService = jwtService;
        this.guestService = guestService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        String jwt = request.getHeader("Authorization");
        log.debug("jwt: {}", jwt);
        if (jwt != null) {
            GitHubUserData gitHubUserData = jwtService.parseJwt(jwt);
            guestService.validateGuestData(gitHubUserData);
            request.setAttribute("guestId", gitHubUserData.getId());
        } else {
            request.setAttribute("guestId", -1L); // will be handled in DAO
        }
        return true;
    }

}

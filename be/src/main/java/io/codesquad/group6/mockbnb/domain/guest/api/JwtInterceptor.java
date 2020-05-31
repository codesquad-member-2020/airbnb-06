package io.codesquad.group6.mockbnb.domain.guest.api;

import io.codesquad.group6.mockbnb.domain.guest.domain.GuestService;
import io.codesquad.group6.mockbnb.githuboauth.GitHubUserData;
import io.codesquad.group6.mockbnb.githuboauth.JwtService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@Service
@Slf4j
public class JwtInterceptor implements HandlerInterceptor {

    private final JwtService jwtService;
    private final GuestService guestService;
    private final Set<String> privateEndpoints;

    public JwtInterceptor(JwtService jwtService, GuestService guestService) {
        this.jwtService = jwtService;
        this.guestService = guestService;
        privateEndpoints = new HashSet<>();
        privateEndpoints.add("/listings/bookmarks");
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
        String jwt = getJwtFromRequestHeader(request);
        long guestId = getGuestIdFromJwt(jwt);
        request.setAttribute("guestId", guestId);
        return okToProceed(request, response, guestId);
    }

    private String getJwtFromRequestHeader(HttpServletRequest request) {
        String jwt = request.getHeader("Authorization");
        log.debug("jwt: {}", jwt);
        return jwt;
    }

    private long getGuestIdFromJwt(String jwt) {
        if (jwt == null) {
            return -1L;
        }
        GitHubUserData gitHubUserData = jwtService.parseJwt(jwt); // may throw JwtException
        guestService.validateGuestData(gitHubUserData); // may throw InvalidGuestDataException
        return gitHubUserData.getId();
    }

    private boolean okToProceed(HttpServletRequest request, HttpServletResponse response, long guestId) throws IOException {
        String requestEndpoint = request.getServletPath();
        if (privateEndpoints.contains(requestEndpoint) && guestId == -1L) {
            response.sendError(401, "Requested operation requires authentication.");
            return false;
        }
        return true;
    }

}

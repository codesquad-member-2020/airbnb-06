package io.codesquad.group6.mockbnb.domain.guest.api;

import io.codesquad.group6.mockbnb.domain.guest.domain.GuestService;
import io.codesquad.group6.mockbnb.domain.guest.exception.UnauthorizedRequestException;
import io.codesquad.group6.mockbnb.githuboauth.GitHubUserData;
import io.codesquad.group6.mockbnb.githuboauth.JwtService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.regex.Pattern;

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
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
        String jwt = getJwtFromRequestHeader(request);
        long guestId = getGuestIdFromJwt(jwt);
        checkIfOkToProceed(request, guestId);
        request.setAttribute("guestId", guestId);
        return true;
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

    private void checkIfOkToProceed(HttpServletRequest request, long guestId) {
        String requestEndpoint = request.getServletPath();
        if (guestId == -1L && endpointIsPrivate(requestEndpoint)) {
            throw new UnauthorizedRequestException("Requested operation requires authentication.");
        }
    }

    private boolean endpointIsPrivate(String requestEndpoint) {
        return requestEndpoint.equals("/listings/bookmarks")
               || Pattern.matches("/listings/\\d+", requestEndpoint)
               || Pattern.matches("/bookings.*", requestEndpoint);
    }

}

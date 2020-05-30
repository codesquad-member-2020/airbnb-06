package io.codesquad.group6.mockbnb.system;

import io.codesquad.group6.mockbnb.domain.guest.exception.InvalidGuestDataException;
import io.codesquad.group6.mockbnb.domain.listing.exception.ListingNotFoundException;
import io.jsonwebtoken.JwtException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.StringJoiner;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(JwtException.class)
    public ResponseEntity<String> handleSignatureException(JwtException e) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                             .body(new StringJoiner("\n").add(e.getMessage())
                                                         .add("JWT exception! Check Authorization header?")
                                                         .toString());
    }

    @ExceptionHandler(InvalidGuestDataException.class)
    public ResponseEntity<String> handleInvalidGuestDataException(InvalidGuestDataException e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                             .body(e.getMessage());
    }

    @ExceptionHandler(ListingNotFoundException.class)
    public ResponseEntity<String> handleListingNotFoundException(ListingNotFoundException e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                             .body(e.getMessage());
    }

}

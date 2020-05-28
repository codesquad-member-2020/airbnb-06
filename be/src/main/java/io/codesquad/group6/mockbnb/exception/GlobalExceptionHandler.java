package io.codesquad.group6.mockbnb.exception;

import io.jsonwebtoken.JwtException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.StringJoiner;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(EmptyResultDataAccessException.class)
    public ResponseEntity<String> handleEmptyResultDataAccessException(EmptyResultDataAccessException e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                             .body(new StringJoiner("\n").add(e.getMessage())
                                                         .add("Not found. The ID probably doesn't exist.")
                                                         .toString());
    }

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

}

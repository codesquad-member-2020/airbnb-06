package io.codesquad.group6.mockbnb.system;

import io.codesquad.group6.mockbnb.domain.booking.exception.BookingNotFoundException;
import io.codesquad.group6.mockbnb.domain.booking.exception.InvalidBookingCancelRequestException;
import io.codesquad.group6.mockbnb.domain.booking.exception.InvalidBookingRequestException;
import io.codesquad.group6.mockbnb.domain.guest.exception.InvalidGuestDataException;
import io.codesquad.group6.mockbnb.domain.guest.exception.UnauthorizedRequestException;
import io.codesquad.group6.mockbnb.domain.listing.exception.InvalidBookmarkRequestException;
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

    @ExceptionHandler(UnauthorizedRequestException.class)
    public ResponseEntity<String> handleUnauthorizedRequestException(UnauthorizedRequestException e) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                             .body(e.getMessage());
    }

    @ExceptionHandler(ListingNotFoundException.class)
    public ResponseEntity<String> handleListingNotFoundException(ListingNotFoundException e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                             .body(e.getMessage());
    }

    @ExceptionHandler(InvalidBookmarkRequestException.class)
    public ResponseEntity<String> handleDuplicateBookmarkException(InvalidBookmarkRequestException e) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                             .body(e.getMessage());
    }

    @ExceptionHandler(BookingNotFoundException.class)
    public ResponseEntity<String> handleBookingNotFoundException(BookingNotFoundException e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                             .body(e.getMessage());
    }

    @ExceptionHandler(InvalidBookingRequestException.class)
    public ResponseEntity<String> handleInvalidBookingRequestException(InvalidBookingRequestException e) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                             .body(e.getMessage());
    }

    @ExceptionHandler(InvalidBookingCancelRequestException.class)
    public ResponseEntity<String> handleInvalidBookingCancelRequestException(InvalidBookingCancelRequestException e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                             .body(e.getMessage());
    }

}

package io.codesquad.group6.mockbnb.domain.booking.exception;

public class InvalidBookingRequestException extends RuntimeException {
    public InvalidBookingRequestException(String s) {
        super(s);
    }
}

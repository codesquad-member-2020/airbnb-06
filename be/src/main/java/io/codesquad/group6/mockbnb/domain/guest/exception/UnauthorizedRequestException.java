package io.codesquad.group6.mockbnb.domain.guest.exception;

public class UnauthorizedRequestException extends RuntimeException {
    public UnauthorizedRequestException(String s) {
        super(s);
    }
}

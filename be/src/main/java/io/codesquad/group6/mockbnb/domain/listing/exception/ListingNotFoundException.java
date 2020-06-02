package io.codesquad.group6.mockbnb.domain.listing.exception;

public class ListingNotFoundException extends RuntimeException {
    public ListingNotFoundException(String s) {
        super(s);
    }
}

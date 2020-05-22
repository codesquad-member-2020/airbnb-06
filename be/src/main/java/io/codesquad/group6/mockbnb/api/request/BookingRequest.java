package io.codesquad.group6.mockbnb.api.request;

import lombok.Data;

import java.time.LocalDate;

@Data
public class BookingRequest {

    private long listingId;
    private LocalDate checkin;
    private LocalDate checkout;
    private int numGuests;

}

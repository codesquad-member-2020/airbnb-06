package io.codesquad.group6.mockbnb.domain.booking.api.dto.response;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class BookingSummary {

    long id;
    String imageUrl;
    String name;
    LocalDate checkin;
    LocalDate checkout;
    int numNights;
    int numGuests;
    double totalPrice;

}

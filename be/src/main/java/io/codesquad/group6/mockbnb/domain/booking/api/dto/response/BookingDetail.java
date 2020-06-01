package io.codesquad.group6.mockbnb.domain.booking.api.dto.response;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class BookingDetail {

    String imageUrl;
    String roomType;
    double housingPrice;
    double rating;
    int numReviews;
    LocalDate checkin;
    LocalDate checkout;
    int numGuests;
    int numNights;
    double totalHousingPrice;
    double cleaningFee;
    double totalPrice;

}

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
    double totalHousingPrice;
    double cleaningFee;
    double totalPrice;
    double rating;
    int numReviews;
    int numGuests;
    int numNights;
    LocalDate checkin;
    LocalDate checkout;

}

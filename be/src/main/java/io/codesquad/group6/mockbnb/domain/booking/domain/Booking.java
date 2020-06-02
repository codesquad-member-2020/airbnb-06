package io.codesquad.group6.mockbnb.domain.booking.domain;

import io.codesquad.group6.mockbnb.domain.booking.api.dto.response.BookingDetail;
import io.codesquad.group6.mockbnb.domain.booking.api.dto.response.BookingSummary;
import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

import static java.time.temporal.ChronoUnit.DAYS;

@Value
@Builder
public class Booking {

    long id;
    String listingName;
    String housingType;
    String imageUrl;
    double housingPrice;
    double cleaningFee;
    double rating;
    int numReviews;
    int numGuests;
    LocalDate checkin;
    LocalDate checkout;

    public BookingSummary toBookingSummary() {
        int numNights = calculateDaysBetween(checkin, checkout);
        return BookingSummary.builder()
                             .id(id)
                             .imageUrl(imageUrl)
                             .listingName(listingName)
                             .checkin(checkin)
                             .checkout(checkout)
                             .numNights(numNights)
                             .numGuests(numGuests)
                             .totalPrice(housingPrice * numNights + cleaningFee)
                             .build();
    }

    public BookingDetail toBookingDetail() {
        int numNights = calculateDaysBetween(checkin, checkout);
        double totalHousingPrice = housingPrice * numNights;
        return BookingDetail.builder()
                            .imageUrl(imageUrl)
                            .housingType(housingType)
                            .housingPrice(housingPrice)
                            .totalHousingPrice(totalHousingPrice)
                            .cleaningFee(cleaningFee)
                            .totalPrice(totalHousingPrice + cleaningFee)
                            .rating(rating)
                            .numReviews(numReviews)
                            .numGuests(numGuests)
                            .numNights(numNights)
                            .checkin(checkin)
                            .checkout(checkout)
                            .build();
    }

    private static int calculateDaysBetween(LocalDate checkin, LocalDate checkout) {
        return (int) DAYS.between(checkin, checkout);
    }

}

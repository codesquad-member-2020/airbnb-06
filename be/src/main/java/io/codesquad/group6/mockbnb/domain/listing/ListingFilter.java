package io.codesquad.group6.mockbnb.domain.listing;

import lombok.Builder;
import lombok.Value;

import java.time.LocalDate;

@Value
@Builder
public class ListingFilter {

    LocalDate checkin;
    LocalDate checkout;
    int numGuests;
    int minPrice;
    int maxPrice;
    int offset;
    int limit;
    double minLatitude;
    double maxLatitude;
    double minLongitude;
    double maxLongitude;

}

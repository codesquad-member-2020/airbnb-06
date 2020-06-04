package io.codesquad.group6.mockbnb.domain.listing.api.dto.response;

import lombok.Builder;
import lombok.Singular;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class ListingSummary {

    long id;
    String name;
    String housingType;
    @Singular List<String> imageUrls;
    double latitude;
    double longitude;
    double price;
    double rating;
    int numReviews;
    int numBedrooms;
    int numBeds;
    Boolean isSuperHost;
    Boolean isBookmarked;

}

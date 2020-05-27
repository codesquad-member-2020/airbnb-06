package io.codesquad.group6.mockbnb.api.response;

import lombok.Builder;
import lombok.Singular;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class ListingSummary {

    long id;
    String name;
    @Singular List<String> imageUrls;
    String housingType;
    int numBedrooms;
    int numBeds;
    double rating;
    int numReviews;
    boolean isSuperHost;
    boolean isBookmarked;

}

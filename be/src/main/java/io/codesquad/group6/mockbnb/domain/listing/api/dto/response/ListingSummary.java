package io.codesquad.group6.mockbnb.domain.listing.api.dto.response;

import com.fasterxml.jackson.annotation.JsonGetter;
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
    double latitude;
    double longitude;

    @JsonGetter("isSuperHost")
    public boolean isSuperHost() {
        return isSuperHost;
    }

    @JsonGetter("isBookmarked")
    public boolean isBookmarked() {
        return isBookmarked;
    }

}

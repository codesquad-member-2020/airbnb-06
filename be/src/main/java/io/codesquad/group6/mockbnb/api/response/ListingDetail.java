package io.codesquad.group6.mockbnb.api.response;

import lombok.Builder;
import lombok.Singular;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class ListingDetail {

    @Singular List<String> imageUrls;
    boolean isLiked;
    String name;
    String location;
    String hostName;
    String roomType;
    int capacity;
    int numBedrooms;
    int numBeds;
    int numBathrooms;
    double price;
    double rating;
    int numReviews;

}

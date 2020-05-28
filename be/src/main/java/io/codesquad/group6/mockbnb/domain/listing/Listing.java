package io.codesquad.group6.mockbnb.domain.listing;

import lombok.Builder;
import lombok.Value;
import org.springframework.data.annotation.Id;

import java.util.List;

@Value
@Builder
public class Listing {

    @Id long id;
    List<String> imageUrls;
    String name;
    String housingType;
    String location;
    String hostName;
    String roomType;
    int capacity;
    int numBedrooms;
    int numBeds;
    double numBathrooms;
    double price;
    double cleaning_fee;
    double rating;
    int numReviews;
    double latitude;
    double longitude;
    boolean isSuperHost;
    boolean isBookmarked;

}

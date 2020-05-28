package io.codesquad.group6.mockbnb.domain.listing;

import lombok.Builder;
import lombok.Data;
import lombok.Singular;
import org.springframework.data.annotation.Id;

import java.util.List;

@Data
@Builder
public class Listing {

    @Id long id;
    @Singular List<String> imageUrls;
    String name;
    String housingType;
    String location;
    String hostName;
    String roomType;
    int capacity;
    int numBedrooms;
    int numBeds;
    int numBathrooms;
    double price;
    double rating;
    double latitude;
    double longitude;
    int numReviews;
    boolean isSuperHost;
    boolean isBookmarked;

}

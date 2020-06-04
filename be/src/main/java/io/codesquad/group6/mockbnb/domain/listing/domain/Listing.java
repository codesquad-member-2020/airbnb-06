package io.codesquad.group6.mockbnb.domain.listing.domain;

import io.codesquad.group6.mockbnb.domain.listing.api.dto.response.ListingDetail;
import io.codesquad.group6.mockbnb.domain.listing.api.dto.response.ListingSummary;
import lombok.Builder;
import lombok.Value;

import java.util.List;

@Value
@Builder
public class Listing {

    long id;
    List<String> imageUrls;
    String name;
    String housingType;
    String location;
    String hostName;
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

    public ListingSummary toListingSummary() {
        return ListingSummary.builder()
                             .id(id)
                             .name(name)
                             .imageUrls(imageUrls)
                             .housingType(housingType)
                             .numBedrooms(numBedrooms)
                             .numBeds(numBeds)
                             .rating(rating)
                             .numReviews(numReviews)
                             .isSuperHost(isSuperHost)
                             .isBookmarked(isBookmarked)
                             .latitude(latitude)
                             .longitude(longitude)
                             .price(price)
                             .build();
    }

    public ListingDetail toListingDetail() {
        return ListingDetail.builder()
                            .imageUrls(imageUrls)
                            .isBookmarked(isBookmarked)
                            .name(name)
                            .location(location)
                            .hostName(hostName)
                            .housingType(housingType)
                            .capacity(capacity)
                            .numBedrooms(numBedrooms)
                            .numBeds(numBeds)
                            .numBathrooms(numBathrooms)
                            .price(price)
                            .rating(rating)
                            .numReviews(numReviews)
                            .build();
    }

}

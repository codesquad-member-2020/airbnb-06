package io.codesquad.group6.mockbnb.mock;

import io.codesquad.group6.mockbnb.api.response.ListingResponse;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@RestController
public class MockController {

    @GetMapping("/mock/listings")
    public ResponseEntity<List<ListingResponse>> getListings(
            @RequestParam(required = false, defaultValue = "la") String city,
            @RequestParam(required = false, defaultValue = "2020-05-22") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkin,
            @RequestParam(required = false, defaultValue = "2020-05-23") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkout,
            @RequestParam(name = "num-guests", required = false, defaultValue = "1") int numGuests,
            @RequestParam(name = "min-price", required = false, defaultValue = "0") int minPrice,
            @RequestParam(name = "max-price", required = false, defaultValue = "10000") int maxPrice,
            @RequestParam(required = false, defaultValue = "0") int offset,
            @RequestParam(required = false, defaultValue = "10") int limit,
            @RequestParam(name = "is-liked", required = false, defaultValue = "false") boolean isLiked) {
        List<ListingResponse> listings = new ArrayList<>();
        listings.add(ListingResponse.builder()
                                    .id(1)
                                    .name("listing1")
                                    .imageUrl("https://a0.muscache.com/im/pictures/dd850460-46df-4422-a98b-86991f8de674.jpg?aki_policy=large")
                                    .imageUrl("https://a0.muscache.com/im/pictures/38165109-1f28-429f-b9fd-99d0932c154e.jpg?aki_policy=large")
                                    .imageUrl("https://a0.muscache.com/im/pictures/df7f56e6-71c0-4402-96de-27604ee4d460.jpg?aki_policy=large")
                                    .housingType("Entire home/apt")
                                    .numBedrooms(2)
                                    .numBeds(3)
                                    .rating(4.85)
                                    .numReviews(210)
                                    .isSuperHost(true)
                                    .isLiked(true)
                                    .build());
        listings.add(ListingResponse.builder()
                                    .id(2)
                                    .name("listing2")
                                    .imageUrl("https://a0.muscache.com/im/pictures/2b5214b8-2e0a-4fcb-8004-0f4b95bdcaa4.jpg?aki_policy=large")
                                    .imageUrl("https://a0.muscache.com/im/pictures/100627966/2ccec29c_original.jpg?aki_policy=large")
                                    .imageUrl("https://a0.muscache.com/im/pictures/92182afd-7553-42a5-8b41-98d60a600062.jpg?aki_policy=large")
                                    .housingType("Private room")
                                    .numBedrooms(1)
                                    .numBeds(2)
                                    .rating(4.93)
                                    .numReviews(52)
                                    .isSuperHost(false)
                                    .isLiked(false)
                                    .build());
        listings.add(ListingResponse.builder()
                                    .id(3)
                                    .name("listing3")
                                    .imageUrl("https://a0.muscache.com/im/pictures/1fa21b5c-b533-49f9-9569-a6808af8bc29.jpg?aki_policy=large")
                                    .imageUrl("https://a0.muscache.com/im/pictures/108111917/046dd104_original.jpg?aki_policy=large")
                                    .imageUrl("https://a0.muscache.com/im/pictures/b2142aa3-f9db-4c32-8eaa-3bf0c6b548c1.jpg?aki_policy=large")
                                    .housingType("House")
                                    .numBedrooms(3)
                                    .numBeds(6)
                                    .rating(4.77)
                                    .numReviews(33)
                                    .isSuperHost(false)
                                    .isLiked(true)
                                    .build());
        return ResponseEntity.ok(listings);
    }

}

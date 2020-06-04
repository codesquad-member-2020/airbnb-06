package io.codesquad.group6.mockbnb.domain.listing.api;

import io.codesquad.group6.mockbnb.domain.listing.api.dto.request.ListingFilter;
import io.codesquad.group6.mockbnb.domain.listing.api.dto.response.ListingDetail;
import io.codesquad.group6.mockbnb.domain.listing.api.dto.response.ListingSummary;
import io.codesquad.group6.mockbnb.domain.listing.api.dto.response.PriceGraphData;
import io.codesquad.group6.mockbnb.domain.listing.domain.ListingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/listings")
@Slf4j
public class ListingController {

    private final ListingService listingService;

    public ListingController(ListingService listingService) {
        this.listingService = listingService;
    }

    @GetMapping("")
    public ResponseEntity<List<ListingSummary>> getListings(
            @RequestParam(required = false, defaultValue = "2020-06-01") LocalDate checkin,
            @RequestParam(required = false, defaultValue = "2020-06-02") LocalDate checkout,
            @RequestParam(name = "num-guests", required = false, defaultValue = "1") int numGuests,
            @RequestParam(name = "min-price", required = false, defaultValue = "0") int minPrice,
            @RequestParam(name = "max-price", required = false, defaultValue = "10000") int maxPrice,
            @RequestParam(required = false, defaultValue = "0") int offset,
            @RequestParam(required = false, defaultValue = "10") int limit,
            @RequestParam(name = "min-latitude", required = false, defaultValue = "37.7") double minLatitude,
            @RequestParam(name = "max-latitude", required = false, defaultValue = "37.85") double maxLatitude,
            @RequestParam(name = "min-longitude", required = false, defaultValue = "-122.55") double minLongitude,
            @RequestParam(name = "max-longitude", required = false, defaultValue = "-122.35") double maxLongitude,
            @RequestAttribute long guestId) {
        ListingFilter listingFilter = ListingFilter.builder()
                                                   .guestId(guestId)
                                                   .checkin(checkin)
                                                   .checkout(checkout)
                                                   .numGuests(numGuests)
                                                   .minPrice(minPrice)
                                                   .maxPrice(maxPrice)
                                                   .offset(offset)
                                                   .limit(limit)
                                                   .minLatitude(minLatitude)
                                                   .maxLatitude(maxLatitude)
                                                   .minLongitude(minLongitude)
                                                   .maxLongitude(maxLongitude)
                                                   .build();
        return ResponseEntity.ok(listingService.getListings(listingFilter));
    }

    @GetMapping("/{listing-id}")
    public ResponseEntity<ListingDetail> getListingDetail(@PathVariable(name = "listing-id") long listingId,
                                                          @RequestAttribute long guestId) {
        return ResponseEntity.ok(listingService.getListing(listingId, guestId));
    }

    @GetMapping("/price-graph")
    public ResponseEntity<PriceGraphData> getPriceGraphData(
            @RequestParam(required = false, defaultValue = "2020-06-01") LocalDate checkin,
            @RequestParam(required = false, defaultValue = "2020-06-02") LocalDate checkout,
            @RequestParam(name = "num-guests", required = false, defaultValue = "1") int numGuests) {
        return ResponseEntity.ok(listingService.getPriceGraphData(checkin, checkout, numGuests));
    }

    @PatchMapping("/{listing-id}")
    public ResponseEntity<?> toggleBookmark(@PathVariable(name = "listing-id") long listingId,
                                            @RequestAttribute long guestId) {
        listingService.toggleBookmark(listingId, guestId);
        return ResponseEntity.accepted()
                             .build();
    }

    @GetMapping("/bookmarks")
    public ResponseEntity<List<ListingSummary>> getBookmarkedListings(@RequestAttribute long guestId) {
        return ResponseEntity.ok(listingService.getBookmarkedListings(guestId));
    }

}

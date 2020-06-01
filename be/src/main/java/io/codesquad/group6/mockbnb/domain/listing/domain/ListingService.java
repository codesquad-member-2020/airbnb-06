package io.codesquad.group6.mockbnb.domain.listing.domain;

import io.codesquad.group6.mockbnb.domain.listing.api.dto.request.BookmarkRequest;
import io.codesquad.group6.mockbnb.domain.listing.api.dto.request.ListingFilter;
import io.codesquad.group6.mockbnb.domain.listing.api.dto.response.ListingDetail;
import io.codesquad.group6.mockbnb.domain.listing.api.dto.response.ListingSummary;
import io.codesquad.group6.mockbnb.domain.listing.api.dto.response.PriceGraphData;
import io.codesquad.group6.mockbnb.domain.listing.data.ListingDao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ListingService {

    private final ListingDao listingDao;

    public ListingService(ListingDao listingDao) {
        this.listingDao = listingDao;
    }

    public List<ListingSummary> getListings(ListingFilter listingFilter) {
        List<Listing> listings = listingDao.findListings(listingFilter);
        return listings.stream()
                       .map(this::mapToListingSummary)
                       .collect(Collectors.toList());
    }

    public ListingDetail getListing(long listingId, long guestId) {
        Listing listing = listingDao.findListingById(listingId, guestId);
        return mapToListingDetail(listing);
    }

    public PriceGraphData getPriceGraphData(LocalDate checkin, LocalDate checkout, int numGuests) {
        return listingDao.findPriceGraphData(checkin, checkout, numGuests);
    }

    public void bookmarkListing(long listingId, long guestId, BookmarkRequest bookmarkRequest) {
        if (bookmarkRequest.getIsBookmarking()) {
            listingDao.bookmarkListing(listingId, guestId);
        } else {
            listingDao.unbookmarkListing(listingId, guestId);
        }
    }

    public List<ListingSummary> getBookmarkedListings(long guestId) {
        List<Listing> bookmarkedListings = listingDao.findBookmarkedListings(guestId);
        return bookmarkedListings.stream()
                                 .map(this::mapToListingSummary)
                                 .collect(Collectors.toList());
    }

    private ListingSummary mapToListingSummary(Listing listing) {
        return ListingSummary.builder()
                             .id(listing.getId())
                             .name(listing.getName())
                             .imageUrls(listing.getImageUrls())
                             .housingType(listing.getHousingType())
                             .numBedrooms(listing.getNumBedrooms())
                             .numBeds(listing.getNumBeds())
                             .rating(listing.getRating())
                             .numReviews(listing.getNumReviews())
                             .isSuperHost(listing.isSuperHost())
                             .isBookmarked(listing.isBookmarked())
                             .latitude(listing.getLatitude())
                             .longitude(listing.getLongitude())
                             .build();
    }

    private ListingDetail mapToListingDetail(Listing listing) {
        return ListingDetail.builder()
                            .imageUrls(listing.getImageUrls())
                            .isBookmarked(listing.isBookmarked())
                            .name(listing.getName())
                            .location(listing.getLocation())
                            .hostName(listing.getHostName())
                            .roomType(listing.getRoomType())
                            .capacity(listing.getCapacity())
                            .numBedrooms(listing.getNumBedrooms())
                            .numBeds(listing.getNumBeds())
                            .numBathrooms(listing.getNumBathrooms())
                            .price(listing.getPrice())
                            .rating(listing.getRating())
                            .numReviews(listing.getNumReviews())
                            .build();
    }

}
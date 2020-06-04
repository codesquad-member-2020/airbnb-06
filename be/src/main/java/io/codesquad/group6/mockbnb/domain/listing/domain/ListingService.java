package io.codesquad.group6.mockbnb.domain.listing.domain;

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
                       .map(Listing::toListingSummary)
                       .collect(Collectors.toList());
    }

    public ListingDetail getListing(long listingId, long guestId) {
        Listing listing = listingDao.findListingById(listingId, guestId);
        return listing.toListingDetail();
    }

    public PriceGraphData getPriceGraphData(LocalDate checkin, LocalDate checkout, int numGuests) {
        return listingDao.findPriceGraphData(checkin, checkout, numGuests);
    }

    public void toggleBookmark(long listingId, long guestId) {
        listingDao.toggleBookmark(listingId, guestId);
    }

    public List<ListingSummary> getBookmarkedListings(long guestId) {
        List<Listing> bookmarkedListings = listingDao.findBookmarkedListings(guestId);
        return bookmarkedListings.stream()
                                 .map(Listing::toListingSummary)
                                 .collect(Collectors.toList());
    }

}

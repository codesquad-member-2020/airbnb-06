package io.codesquad.group6.mockbnb.domain.listing;

import io.codesquad.group6.mockbnb.api.response.ListingDetail;
import io.codesquad.group6.mockbnb.api.response.ListingSummary;
import io.codesquad.group6.mockbnb.data.ListingDao;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
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

    public ListingDetail getListing(long listingId) {
        Listing listing = listingDao.findListingById(listingId);
        return mapToListingDetail(listing);
    }

    private ListingSummary mapToListingSummary(Listing listing) {
        return null;
    }

    private ListingDetail mapToListingDetail(Listing listing) {
        return null;
    }

}

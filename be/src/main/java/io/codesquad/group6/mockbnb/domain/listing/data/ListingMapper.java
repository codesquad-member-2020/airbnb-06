package io.codesquad.group6.mockbnb.domain.listing.data;

import io.codesquad.group6.mockbnb.domain.listing.domain.Listing;
import io.codesquad.group6.mockbnb.domain.listing.exception.ListingNotFoundException;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

class ListingMapper implements RowMapper<Listing> {

    public static ListingMapper instance() {
        return new ListingMapper();
    }

    @Override
    public Listing mapRow(ResultSet rs, int rowNum) throws SQLException {
        return Listing.builder()
                      .id(rs.getLong("l.id"))
                      .imageUrls(splitConcatenatedImageUrls(rs.getString("l_image_urls")))
                      .name(rs.getString("l.name"))
                      .housingType(rs.getString("l.housing_type"))
                      .location(rs.getString("l_location"))
                      .hostName(rs.getString("h.name"))
                      .roomType(rs.getString("l.housing_type"))
                      .capacity(rs.getInt("l.capacity"))
                      .numBedrooms(rs.getInt("l.num_bedrooms"))
                      .numBeds(rs.getInt("l.num_beds"))
                      .numBathrooms(rs.getDouble("l.num_bathrooms"))
                      .price(rs.getDouble("l.price"))
                      .cleaning_fee(rs.getDouble("l.cleaning_fee"))
                      .rating(rs.getDouble("l.rating"))
                      .numReviews(rs.getInt("l.num_reviews"))
                      .latitude(rs.getDouble("l.latitude"))
                      .longitude(rs.getDouble("l.longitude"))
                      .isSuperHost(rs.getBoolean("h.is_superhost"))
                      .isBookmarked(rs.getBoolean("l_is_bookmarked"))
                      .build();
    }

    private static List<String> splitConcatenatedImageUrls(String concatenatedImageUrls) {
        try {
            return Arrays.asList(concatenatedImageUrls.split(","));
        } catch (NullPointerException e) { // rs is empty... probably
            throw new ListingNotFoundException("Not found. The ID probably doesn't exist.");
        }
    }

}

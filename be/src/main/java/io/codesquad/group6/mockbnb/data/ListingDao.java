package io.codesquad.group6.mockbnb.data;

import io.codesquad.group6.mockbnb.domain.listing.Listing;
import io.codesquad.group6.mockbnb.domain.listing.ListingFilter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;

@Repository
public class ListingDao {

    private final JdbcTemplate jdbcTemplate;

    public ListingDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<Listing> findListings(ListingFilter listingFilter) {
        return null;
    }

    public Listing findListingById(long id) {
        return null;
    }

}

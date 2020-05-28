package io.codesquad.group6.mockbnb.data;

import io.codesquad.group6.mockbnb.domain.listing.Listing;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.time.LocalDate;
import java.util.List;

@Repository
public class ListingDao {

    private final JdbcTemplate jdbcTemplate;

    public ListingDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<Listing> findListings(LocalDate checkin,
                                      LocalDate checkout,
                                      int numGuests,
                                      int minPrice,
                                      int maxPrice,
                                      int offset,
                                      int limit,
                                      double minLatitude,
                                      double maxLatitude,
                                      double minLongitude,
                                      double maxLongitude) {
        return null;
    }

    public Listing findListingById(long id) {
        return null;
    }

}

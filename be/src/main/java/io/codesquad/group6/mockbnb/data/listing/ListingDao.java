package io.codesquad.group6.mockbnb.data.listing;

import io.codesquad.group6.mockbnb.domain.listing.Listing;
import io.codesquad.group6.mockbnb.domain.listing.ListingFilter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;

@Repository
public class ListingDao {

    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public ListingDao(DataSource dataSource) {
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public List<Listing> findListings(ListingFilter listingFilter) {
        return null;
    }

    public Listing findListingById(long listingId, long guestId) {
        String sql = "SELECT l.id, l.name, CONCAT_WS(', ', l.neighborhood, l.city, l.state, l.country) AS l_location, " +
                         "l.latitude, l.longitude, l.housing_type, l.capacity, l.num_bathrooms, l.num_bedrooms, l.num_beds, " +
                         "l.price, l.cleaning_fee, l.num_reviews, l.rating, " +
                         "EXISTS(SELECT b.id " +
                             "FROM bookmark b " +
                             "WHERE b.guest = :g_id " +
                                 "AND b.listing = l.id) AS l_is_bookmarked, " +
                         "GROUP_CONCAT(i.image_url) AS l_image_urls, " +
                         "h.id, h.name, h.is_superhost " +
                     "FROM listing l " +
                         "JOIN host h ON l.host = h.id " +
                         "JOIN image i ON l.id = i.listing " +
                     "WHERE l.id = :l_id";
        SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue("l_id", listingId)
                                                                           .addValue("g_id", guestId);
        return namedParameterJdbcTemplate.queryForObject(sql, sqlParameterSource, ListingMapper.instance());
    }

}

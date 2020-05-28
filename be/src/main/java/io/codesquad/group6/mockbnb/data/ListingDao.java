package io.codesquad.group6.mockbnb.data;

import io.codesquad.group6.mockbnb.domain.listing.Listing;
import io.codesquad.group6.mockbnb.domain.listing.ListingFilter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;
import java.util.StringJoiner;

@Repository
public class ListingDao {

    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public ListingDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public List<Listing> findListings(ListingFilter listingFilter) {
        return null;
    }

    public Listing findListingById(long listingId, long guestId) {
        String sql = "SELECT l.id, " +
                         "l.name, " +
                         "l.neighborhood, " +
                         "l.city, " +
                         "l.state, " +
                         "l.country, " +
                         "l.latitude, " +
                         "l.longitude, " +
                         "l.housing_type, " +
                         "l.capacity, " +
                         "l.num_bathrooms, " +
                         "l.num_bedrooms, " +
                         "l.num_beds, " +
                         "l.price, " +
                         "l.cleaning_fee, " +
                         "l.num_reviews, " +
                         "l.rating, " +
                         "h.id, " +
                         "h.name, " +
                         "h.is_superhost " +
                     "FROM listing l " +
                         "JOIN host h ON l.host = h.id " +
                     "WHERE l.id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{listingId}, (rs, rowNum) ->
                Listing.builder()
                       .id(rs.getLong("l.id"))
                       .imageUrls(findListingImagesByListingId(listingId))
                       .name(rs.getString("l.name"))
                       .housingType(rs.getString("l.housing_type"))
                       .location(new StringJoiner(", ").add(rs.getString("l.neighborhood"))
                                                       .add(rs.getString("l.city"))
                                                       .add(rs.getString("l.state"))
                                                       .add(rs.getString("l.country"))
                                                       .toString())
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
                       .isBookmarked(findIfListingIsBookmarkedByGuest(listingId, guestId))
                       .build()
        );
    }

    private List<String> findListingImagesByListingId(long listingId) {
        String sql = "SELECT image_url " +
                     "FROM image i " +
                     "WHERE i.listing = ?";
        return jdbcTemplate.queryForList(sql, String.class, listingId);
    }

    private boolean findIfListingIsBookmarkedByGuest(long listingId, long guestId) {
        if (guestId == -1L) {
            return false;
        }
        String sql = "SELECT COUNT(*) " +
                     "FROM bookmark b " +
                     "WHERE b.listing = :l_id " +
                         "AND b.guest = :g_id";
        SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue("l_id", listingId)
                                                                           .addValue("g_id", guestId);
        int count = namedParameterJdbcTemplate.queryForObject(sql, sqlParameterSource, Integer.class);
        return count >= 1;
    }

}

package io.codesquad.group6.mockbnb.domain.listing.api.dto.request;

import lombok.Builder;
import lombok.Value;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

import java.time.LocalDate;

@Value
@Builder
public class ListingFilter {

    long guestId;
    LocalDate checkin;
    LocalDate checkout;
    int numGuests;
    int minPrice;
    int maxPrice;
    int offset;
    int limit;
    double minLatitude;
    double maxLatitude;
    double minLongitude;
    double maxLongitude;

    public SqlParameterSource toSqlParameterSource() {
        return new MapSqlParameterSource().addValue("g_id", guestId)
                                          .addValue("checkin", checkin)
                                          .addValue("checkout", checkout)
                                          .addValue("num_guests", numGuests)
                                          .addValue("min_price", minPrice)
                                          .addValue("max_price", maxPrice)
                                          .addValue("offset", offset)
                                          .addValue("limit", limit)
                                          .addValue("min_latitude", minLatitude)
                                          .addValue("max_latitude", maxLatitude)
                                          .addValue("min_longitude", minLongitude)
                                          .addValue("max_longitude", maxLongitude);
    }

}

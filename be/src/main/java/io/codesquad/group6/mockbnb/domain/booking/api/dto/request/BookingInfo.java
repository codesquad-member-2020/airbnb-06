package io.codesquad.group6.mockbnb.domain.booking.api.dto.request;

import lombok.Builder;
import lombok.Value;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

import java.time.LocalDate;

@Value
@Builder
public class BookingInfo {

    long guestId;
    long listingId;
    LocalDate checkin;
    LocalDate checkout;
    int numGuests;

    public SqlParameterSource toSqlParameterSource() {
        return new MapSqlParameterSource().addValue("g_id", guestId)
                                          .addValue("l_id", listingId)
                                          .addValue("checkin", checkin)
                                          .addValue("checkout", checkout)
                                          .addValue("num_guests", numGuests);
    }

}

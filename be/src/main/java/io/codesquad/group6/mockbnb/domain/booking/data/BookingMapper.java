package io.codesquad.group6.mockbnb.domain.booking.data;

import io.codesquad.group6.mockbnb.domain.booking.domain.Booking;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BookingMapper implements RowMapper<Booking> {

    public static BookingMapper getInstance() {
        return new BookingMapper();
    }

    @Override
    public Booking mapRow(ResultSet rs, int rowNum) throws SQLException {
        return Booking.builder()
                      .id(rs.getLong("l.id"))
                      .name(rs.getString("l.name"))
                      .housingType(rs.getString("l.housing_type"))
                      .imageUrl(rs.getString("l_image_url"))
                      .housingPrice(rs.getDouble("l.price"))
                      .cleaningFee(rs.getDouble("l.cleaning_fee"))
                      .rating(rs.getDouble("l.rating"))
                      .numReviews(rs.getInt("l.num_reviews"))
                      .numGuests(rs.getInt("b.num_guests"))
                      .checkin(rs.getDate("b.checkin").toLocalDate())
                      .checkout(rs.getDate("b.checkout").toLocalDate())
                      .build();
    }

}

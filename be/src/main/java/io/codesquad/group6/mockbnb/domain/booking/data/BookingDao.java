package io.codesquad.group6.mockbnb.domain.booking.data;

import io.codesquad.group6.mockbnb.domain.booking.domain.Booking;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;

@Repository
public class BookingDao {

    private final JdbcTemplate jdbcTemplate;

    public BookingDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Booking findBookingById(long bookingId) {
        String sql = "";
        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> null, bookingId);
    }

    public List<Booking> findBookingsByGuestId(long guestId) {
        String sql = "";
        return jdbcTemplate.query(sql, (rs, rowNum) -> null, guestId);
    }

}

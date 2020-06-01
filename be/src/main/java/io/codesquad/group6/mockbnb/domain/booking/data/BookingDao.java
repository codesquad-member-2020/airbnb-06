package io.codesquad.group6.mockbnb.domain.booking.data;

import io.codesquad.group6.mockbnb.domain.booking.domain.Booking;
import io.codesquad.group6.mockbnb.domain.booking.exception.BookingNotFoundException;
import org.springframework.dao.EmptyResultDataAccessException;
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
        String sql = "SELECT l.id, l.name, l.housing_type, l.price, l.cleaning_fee, l.rating, l.num_reviews, " +
                         "(SELECT image_url " +
                             "FROM image " +
                             "WHERE id = (SELECT MIN(id) " +
                                 "FROM image " +
                                 "WHERE listing = b.listing)) AS l_image_url, " +
                         "b.num_guests, b.checkin, b.checkout " +
                     "FROM booking b " +
                         "JOIN listing l ON b.listing = l.id " +
                     "WHERE b.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, BookingMapper.getInstance(), bookingId);
        } catch (EmptyResultDataAccessException e) {
            throw new BookingNotFoundException("No booking by the provided ID exists.");
        }
    }

    public List<Booking> findBookingsByGuestId(long guestId) {
        String sql = "";
        return jdbcTemplate.query(sql, (rs, rowNum) -> null, guestId);
    }

}

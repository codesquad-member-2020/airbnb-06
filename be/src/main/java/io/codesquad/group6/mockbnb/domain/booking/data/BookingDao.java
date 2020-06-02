package io.codesquad.group6.mockbnb.domain.booking.data;

import io.codesquad.group6.mockbnb.domain.booking.api.dto.request.BookingInfo;
import io.codesquad.group6.mockbnb.domain.booking.domain.Booking;
import io.codesquad.group6.mockbnb.domain.booking.exception.BookingNotFoundException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;

@Repository
public class BookingDao {

    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public BookingDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public Booking findBookingById(long bookingId, long guestId) {
        String sql = "SELECT l.id, l.name, l.housing_type, l.price, l.cleaning_fee, l.rating, l.num_reviews, " +
                         "(SELECT image_url " +
                             "FROM image " +
                             "WHERE id = (SELECT MIN(id) " +
                                 "FROM image " +
                                 "WHERE listing = b.listing)) AS l_image_url, " +
                         "b.num_guests, b.checkin, b.checkout " +
                     "FROM booking b " +
                         "JOIN listing l ON b.listing = l.id " +
                     "WHERE b.id = ? AND b.guest = ?";
        try {
            return jdbcTemplate.queryForObject(sql, BookingMapper.getInstance(), bookingId, guestId);
        } catch (EmptyResultDataAccessException e) {
            throw new BookingNotFoundException("No booking by the provided ID exists " +
                                               "or you don't have the permission to view the booking.");
        }
    }

    public List<Booking> findBookingsByGuestId(long guestId) {
        String sql = "SELECT l.id, l.name, l.housing_type, l.price, l.cleaning_fee, l.rating, l.num_reviews, " +
                         "(SELECT image_url " +
                             "FROM image " +
                             "WHERE id = (SELECT MIN(id) " +
                                 "FROM image " +
                                 "WHERE listing = b.listing)) AS l_image_url, " +
                         "b.num_guests, b.checkin, b.checkout " +
                     "FROM booking b " +
                         "JOIN listing l ON b.listing = l.id " +
                     "WHERE b.guest = ?";
        return jdbcTemplate.query(sql, BookingMapper.getInstance(), guestId);
    }

    public long insertBooking(BookingInfo bookingInfo) {
        String sql = "";
        SqlParameterSource sqlParameterSource = bookingInfo.toSqlParameterSource();
        KeyHolder keyHolder = new GeneratedKeyHolder();
        namedParameterJdbcTemplate.update(sql, sqlParameterSource, keyHolder);
        return keyHolder.getKey().longValue();
    }


    public void deleteBooking(long bookingId, long guestId) {
        String sql = "";
        jdbcTemplate.update(sql, bookingId, guestId);
    }

}

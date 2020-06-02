package io.codesquad.group6.mockbnb.domain.booking.data;

import io.codesquad.group6.mockbnb.domain.booking.api.dto.request.BookingInfo;
import io.codesquad.group6.mockbnb.domain.booking.domain.Booking;
import io.codesquad.group6.mockbnb.domain.booking.exception.BookingNotFoundException;
import io.codesquad.group6.mockbnb.domain.booking.exception.InvalidBookingCancelRequestException;
import io.codesquad.group6.mockbnb.domain.booking.exception.InvalidBookingRequestException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;
import java.util.Objects;

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
        String sql = "INSERT INTO booking (listing, guest, checkin, checkout, num_guests)" +
                     "SELECT :l_id, :g_id, :checkin, :checkout, :num_guests " +
                     "FROM DUAL " +
                     "WHERE NOT EXISTS(SELECT b.id " +
                             "FROM booking b " +
                             "WHERE b.listing = :l_id " +
                                 "AND ((:checkin <= b.checkin AND b.checkin < :checkout) " +
                                 "OR (:checkin < b.checkout AND b.checkout <= :checkout) " +
                                 "OR (b.checkin < :checkin AND :checkout < checkout))) " +
                         "AND :num_guests <= (SELECT l.capacity " +
                             "FROM listing l " +
                             "WHERE l.id = :l_id)";
        SqlParameterSource sqlParameterSource = bookingInfo.toSqlParameterSource();
        KeyHolder keyHolder = new GeneratedKeyHolder();
        namedParameterJdbcTemplate.update(sql, sqlParameterSource, keyHolder);
        return getGeneratedId(keyHolder);
    }


    public void deleteBooking(long bookingId, long guestId) {
        String sql = "DELETE FROM booking " +
                     "WHERE id = ? " +
                         "AND guest = ?";
        int numRowsAffected = jdbcTemplate.update(sql, bookingId, guestId);
        if (numRowsAffected != 1) {
            throw new InvalidBookingCancelRequestException("Failed to cancel the booking. " +
                                                           "Either you are trying to delete a booking that does not exist " +
                                                           "or you don't have the permission to delete the booking.");
        }
    }

    private long getGeneratedId(KeyHolder keyHolder) {
        try {
            return Objects.requireNonNull(keyHolder.getKey())
                          .longValue();
        } catch (NullPointerException e) {
            throw new InvalidBookingRequestException("Failed to book the listing. " +
                                                     "Either the listing is already booked for the requested period " +
                                                     "or the requested number of guests exceeds the listing capacity.");
        }
    }

}

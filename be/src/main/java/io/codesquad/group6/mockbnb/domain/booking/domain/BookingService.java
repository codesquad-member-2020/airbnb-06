package io.codesquad.group6.mockbnb.domain.booking.domain;

import io.codesquad.group6.mockbnb.domain.booking.api.dto.request.BookingInfo;
import io.codesquad.group6.mockbnb.domain.booking.api.dto.response.BookingDetail;
import io.codesquad.group6.mockbnb.domain.booking.api.dto.response.BookingResponse;
import io.codesquad.group6.mockbnb.domain.booking.api.dto.response.BookingSummary;
import io.codesquad.group6.mockbnb.domain.booking.data.BookingDao;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookingService {

    private final BookingDao bookingDao;

    public BookingService(BookingDao bookingDao) {
        this.bookingDao = bookingDao;
    }

    public List<BookingSummary> getBookings(long guestId) {
        List<Booking> bookings = bookingDao.findBookingsByGuestId(guestId);
        return bookings.stream()
                       .map(Booking::toBookingSummary)
                       .collect(Collectors.toList());
    }

    public BookingDetail getBookingDetail(long bookingId, long guestId) {
        Booking booking = bookingDao.findBookingById(bookingId, guestId);
        return booking.toBookingDetail();
    }

    public BookingResponse book(BookingInfo bookingInfo) {
        long bookingId = bookingDao.insertBooking(bookingInfo);
        return BookingResponse.builder()
                              .bookingId(bookingId)
                              .build();
    }

    public void cancelBooking(long bookingId, long guestId) {
        bookingDao.deleteBooking(bookingId, guestId);
    }

}

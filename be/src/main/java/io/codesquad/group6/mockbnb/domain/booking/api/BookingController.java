package io.codesquad.group6.mockbnb.domain.booking.api;

import io.codesquad.group6.mockbnb.domain.booking.api.dto.response.BookingDetail;
import io.codesquad.group6.mockbnb.domain.booking.api.dto.response.BookingSummary;
import io.codesquad.group6.mockbnb.domain.booking.domain.BookingService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/bookings")
public class BookingController {

    private final BookingService bookingService;

    public BookingController(BookingService bookingService) {
        this.bookingService = bookingService;
    }

    @GetMapping("")
    public ResponseEntity<List<BookingSummary>> getBookings(@RequestAttribute long guestId) {
        return ResponseEntity.ok(bookingService.getBookings(guestId));
    }

    @GetMapping("/{booking-id}")
    public ResponseEntity<BookingDetail> getBookingDetail(@PathVariable(name = "booking-id") long bookingId,
                                                          @RequestAttribute long guestId) {
        return ResponseEntity.ok(bookingService.getBookingDetail(bookingId, guestId));
    }

}

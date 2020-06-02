package io.codesquad.group6.mockbnb.domain.booking.api;

import io.codesquad.group6.mockbnb.domain.booking.api.dto.request.BookingInfo;
import io.codesquad.group6.mockbnb.domain.booking.api.dto.request.BookingRequest;
import io.codesquad.group6.mockbnb.domain.booking.api.dto.response.BookingDetail;
import io.codesquad.group6.mockbnb.domain.booking.api.dto.response.BookingResponse;
import io.codesquad.group6.mockbnb.domain.booking.api.dto.response.BookingSummary;
import io.codesquad.group6.mockbnb.domain.booking.domain.BookingService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
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

    @PostMapping("")
    public ResponseEntity<BookingResponse> book(@RequestBody BookingRequest bookingRequest,
                                                @RequestAttribute long guestId) {
        BookingInfo bookingInfo = BookingInfo.builder()
                                             .guestId(guestId)
                                             .listingId(bookingRequest.getListingId())
                                             .checkin(bookingRequest.getCheckin())
                                             .checkout(bookingRequest.getCheckout())
                                             .numGuests(bookingRequest.getNumGuests())
                                             .build();
        return ResponseEntity.status(HttpStatus.ACCEPTED)
                             .body(bookingService.book(bookingInfo));
    }

    @DeleteMapping("/{booking-id}")
    public ResponseEntity<?> cancelBooking(@PathVariable(name = "booking-id") long bookingId,
                                           @RequestAttribute long guestId) {
        bookingService.cancelBooking(bookingId, guestId);
        return ResponseEntity.status(HttpStatus.ACCEPTED)
                             .build();
    }

    @GetMapping("/{booking-id}")
    public ResponseEntity<BookingDetail> getBookingDetail(@PathVariable(name = "booking-id") long bookingId,
                                                          @RequestAttribute long guestId) {
        return ResponseEntity.ok(bookingService.getBookingDetail(bookingId, guestId));
    }

}

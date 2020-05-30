package io.codesquad.group6.mockbnb.domain.listing.api.dto.response;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class PriceGraphData {

    double avg;
    int[] priceDistribution;

}

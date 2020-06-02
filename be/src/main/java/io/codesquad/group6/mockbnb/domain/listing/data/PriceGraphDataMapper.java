package io.codesquad.group6.mockbnb.domain.listing.data;

import io.codesquad.group6.mockbnb.domain.listing.api.dto.response.PriceGraphData;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PriceGraphDataMapper implements RowMapper<PriceGraphData> {

    public static PriceGraphDataMapper instance() {
        return new PriceGraphDataMapper();
    }

    @Override
    public PriceGraphData mapRow(ResultSet rs, int rowNum) throws SQLException {
        String concatenatedPriceStrings = rs.getString("l_prices");
        String[] priceStrings = splitConcatenatedPriceStrings(concatenatedPriceStrings);
        return PriceGraphData.builder()
                             .avg(rs.getDouble("l_price_avg"))
                             .priceDistribution(computePriceDistribution(priceStrings))
                             .build();
    }

    private String[] splitConcatenatedPriceStrings(String concatenatedPriceStrings) {
        try {
            return concatenatedPriceStrings.split(",");
        } catch (NullPointerException e) { // rs is empty... probably
            // if rs is empty, i.e. no listing satisfying the querying conditions is found,
            // we want to return avg = 0 and distribution array filled with 0.
            return new String[0];
        }
    }

    private int[] computePriceDistribution(String[] priceStrings) {
        int[] priceDistribution = new int[50];
        for (String priceString : priceStrings) {
            double price = Double.parseDouble(priceString);
            int index = Math.min((int) price / 20, 50 - 1);
            priceDistribution[index]++;
        }
        return priceDistribution;
    }

}

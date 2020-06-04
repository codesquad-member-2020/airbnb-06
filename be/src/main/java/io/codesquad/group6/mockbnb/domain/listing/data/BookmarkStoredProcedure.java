package io.codesquad.group6.mockbnb.domain.listing.data;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;

@Component
public class BookmarkStoredProcedure implements InitializingBean {

    private final JdbcTemplate jdbcTemplate;
    private static final String DROP_STORED_PROC =
            "DROP PROCEDURE IF EXISTS toggle_bookmark;";
    private static final String CREATE_STORED_PROC =
            "CREATE PROCEDURE toggle_bookmark(IN l_id BIGINT, IN g_id BIGINT) " +
            "BEGIN " +
                "IF EXISTS(SELECT * " +
                    "FROM bookmark " +
                    "WHERE listing = l_id " +
                        "AND guest = g_id) " +
                "THEN " +
                    "DELETE " +
                    "FROM bookmark " +
                    "WHERE listing = l_id; " +
                "ELSE " +
                    "INSERT INTO bookmark (listing, guest) " +
                    "VALUES (l_id, g_id); " +
                "END IF; " +
            "END;";

    public BookmarkStoredProcedure(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public void afterPropertiesSet() {
        jdbcTemplate.execute(DROP_STORED_PROC);
        jdbcTemplate.execute(CREATE_STORED_PROC);
    }

}

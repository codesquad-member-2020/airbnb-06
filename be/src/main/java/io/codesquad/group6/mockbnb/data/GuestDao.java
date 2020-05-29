package io.codesquad.group6.mockbnb.data;

import io.codesquad.group6.mockbnb.auth.GitHubUserData;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository
public class GuestDao {

    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public GuestDao(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public void insertOrUpdateOnDuplicateKey(GitHubUserData gitHubUserData) {
        String sql = "INSERT INTO guest (id, login, email) " +
                     "VALUES (:id, :login, :email) " +
                     "ON DUPLICATE KEY " +
                         "UPDATE login = :login, " +
                             "email = :email";
        SqlParameterSource sqlParameterSource = new MapSqlParameterSource().addValue("id", gitHubUserData.getId())
                                                                           .addValue("login", gitHubUserData.getLogin())
                                                                           .addValue("email", gitHubUserData.getEmail());
        namedParameterJdbcTemplate.update(sql, sqlParameterSource);
    }

    public boolean hasGuestById(long guestId) {
        String sql = "SELECT EXISTS(SELECT id " +
                         "FROM guest " +
                         "WHERE id = ?)";
        return jdbcTemplate.queryForObject(sql, Boolean.class, guestId);
    }

}

package io.codesquad.group6.mockbnb.githuboauth;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class GitHubUserData {

    private long id;
    private String login;
    private String email;

}

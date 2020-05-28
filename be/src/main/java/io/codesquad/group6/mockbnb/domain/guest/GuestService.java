package io.codesquad.group6.mockbnb.domain.guest;

import io.codesquad.group6.mockbnb.auth.GitHubUserData;
import io.codesquad.group6.mockbnb.data.GuestDao;
import org.springframework.stereotype.Service;

@Service
public class GuestService {

    private final GuestDao guestDao;

    public GuestService(GuestDao guestDao) {
        this.guestDao = guestDao;
    }

    public void insertOrUpdateOnDuplicateKey(GitHubUserData gitHubUserData) {
        guestDao.insertOrUpdateOnDuplicateKey(gitHubUserData);
    }

}

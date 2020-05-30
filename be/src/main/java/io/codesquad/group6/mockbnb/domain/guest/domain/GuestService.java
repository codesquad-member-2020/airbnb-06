package io.codesquad.group6.mockbnb.domain.guest.domain;

import io.codesquad.group6.mockbnb.githuboauth.GitHubUserData;
import io.codesquad.group6.mockbnb.domain.guest.exception.InvalidGuestDataException;
import io.codesquad.group6.mockbnb.domain.guest.data.GuestDao;
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

    public void validateGuestData(GitHubUserData gitHubUserData) {
        long guestId = gitHubUserData.getId();
        boolean userDataExists = guestDao.hasGuestById(guestId);
        if (!userDataExists) {
            throw new InvalidGuestDataException("Guest data found in the provided JWT is not in our database.");
        }
    }

}

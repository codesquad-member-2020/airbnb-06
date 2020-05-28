package io.codesquad.group6.mockbnb.domain.guest;

import io.codesquad.group6.mockbnb.auth.GitHubUserData;
import io.codesquad.group6.mockbnb.data.GuestDao;
import io.codesquad.group6.mockbnb.exception.InvalidGuestDataException;
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

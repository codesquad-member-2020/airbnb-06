CREATE TABLE IF NOT EXISTS host
(
    id           BIGINT PRIMARY KEY,
    name         VARCHAR(64),
    is_superhost TINYINT(1)
);

CREATE TABLE IF NOT EXISTS listing
(
    id            BIGINT PRIMARY KEY,
    host          BIGINT,
    name          VARCHAR(128),
    neighborhood  VARCHAR(128),
    city          VARCHAR(64),
    state         VARCHAR(64),
    country       VARCHAR(64),
    latitude      DECIMAL(8, 5),
    longitude     DECIMAL(8, 5),
    housing_type  VARCHAR(64),
    capacity      INT,
    num_bathrooms DECIMAL(3, 1),
    num_bedrooms  INT,
    num_beds      INT,
    price         DECIMAL(7, 2),
    cleaning_fee  DECIMAL(6, 2),
    num_reviews   INT,
    rating        DECIMAL(3, 2),
    FOREIGN KEY (host) REFERENCES host (id)
);

CREATE TABLE IF NOT EXISTS image
(
    id        BIGINT PRIMARY KEY AUTO_INCREMENT,
    listing   BIGINT,
    image_url VARCHAR(256),
    FOREIGN KEY (listing) REFERENCES listing (id)
);

CREATE TABLE IF NOT EXISTS guest
(
    id    BIGINT PRIMARY KEY, -- use GitHub ID
    login VARCHAR(64),
    email VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS booking
(
    id         BIGINT PRIMARY KEY AUTO_INCREMENT,
    listing    BIGINT,
    guest      BIGINT,
    checkin    DATE,
    checkout   DATE,
    num_guests INT,
    FOREIGN KEY (listing) REFERENCES listing (id),
    FOREIGN KEY (guest) REFERENCES guest (id)
);

CREATE TABLE IF NOT EXISTS bookmark
(
    listing BIGINT,
    guest   BIGINT,
    PRIMARY KEY (listing, guest),
    FOREIGN KEY (listing) REFERENCES listing (id),
    FOREIGN KEY (guest) REFERENCES guest (id)
);

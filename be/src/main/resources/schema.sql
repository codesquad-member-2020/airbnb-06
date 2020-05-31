CREATE TABLE IF NOT EXISTS host
(
    id           BIGINT PRIMARY KEY,
    name         VARCHAR(64),
    is_superhost TINYINT(1)
);

CREATE TABLE IF NOT EXISTS listing
(
    id            BIGINT PRIMARY KEY,
    host          BIGINT REFERENCES host (id),
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
    rating        DECIMAL(3, 2)
);

CREATE TABLE IF NOT EXISTS image
(
    id        BIGINT PRIMARY KEY AUTO_INCREMENT,
    listing   BIGINT REFERENCES listing (id),
    image_url VARCHAR(256)
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
    listing    BIGINT REFERENCES listing (id),
    guest      BIGINT REFERENCES guest (id),
    checkin    DATE,
    checkout   DATE,
    num_guests INT
);

CREATE TABLE IF NOT EXISTS bookmark
(
    listing BIGINT REFERENCES listing (id),
    guest   BIGINT REFERENCES guest (id),
    PRIMARY KEY (listing, guest)
);

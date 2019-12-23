DROP TABLE IF EXISTS albums;

CREATE TABLE albums ( -- create table and add rows
  id INTEGER PRIMARY KEY AUTOINCREMENT, -- take care of IDs for us
  name TEXT,
  year INTEGER,
  artist_id INTEGER
);

INSERT INTO albums (name, year, artist_id)
  VALUES ( 'Unknown Plasures', 1979, 1);

INSERT INTO albums (name, year, artist_id)
  VALUES ( 'Closer', 1980, 1);

INSERT INTO albums (name, year, artist_id)
  VALUES ('The Rabbit That Hunts Tigers', 2018, 2);


DROP TABLE IF EXISTS artists;

CREATE TABLE artists ( -- create table and add rows
  id INTEGER PRIMARY KEY AUTOINCREMENT, -- take care of IDs for us
  name TEXT,
  formed INTEGER,
  together BOOLEAN,
  photo TEXT

);

INSERT INTO artists (name, formed, together, photo) -- insert first artist in
  VALUES (
    "Joy Division",
    1978,
    0,
    "http//www.joy-division-img.com"

  );

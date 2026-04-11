CREATE TABLE books (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  title       TEXT    NOT NULL,
  publisher   TEXT    NOT NULL,
  year        INTEGER NOT NULL,
  cover       TEXT,
  sort_order  INTEGER NOT NULL DEFAULT 0
);

-- description paragraphs (ordered array of HTML strings)
CREATE TABLE book_descriptions (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  book_id    INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
  paragraph  TEXT    NOT NULL,
  position   INTEGER NOT NULL
);

-- endorsement quotes
CREATE TABLE book_endorsements (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  book_id     INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
  quote       TEXT    NOT NULL,
  attribution TEXT    NOT NULL,
  position    INTEGER NOT NULL
);
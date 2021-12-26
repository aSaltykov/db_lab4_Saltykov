CREATE TRIGGER artists_name_ 
AFTER INSERT ON artist
FOR EACH ROW EXECUTE FUNCTION names_input();

CREATE OR REPLACE FUNCTION names_input() RETURNS trigger AS
$$
     BEGIN
          UPDATE artist
          SET artist_name = artist_name || ' this is a new artist in the table' WHERE artist.artist_id = NEW.artist_id; 
      RETURN NULL;
     END;
$$ LANGUAGE 'plpgsql';
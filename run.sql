--Function
create or replace function about_bio_counter(the_most_famous_painting_name1 text) returns text as
$$
	declare
		result_about_bio_counter integer;
		
	begin
		
		select count(*) into result_about_bio_counter from bio
			left join the_most_famous_painting on bio.painting_id = the_most_famous_painting.painting_id
				where the_most_famous_painting.painting_name = the_most_famous_painting_name1;
		if result_about_bio_counter = 0 then
				return 'Такої картини не існує в таблиці';
			else
				return  result_about_bio_counter || ' - Кількість заданої картини у about_bio';
		end if;
	end;

$$ language 'plpgsql';

--функція повинна повернути повідомлення, що заданої картини не існує:
select * from about_bio_counter('2');

--функція повинна повернути повідомлення, що кількість заданої картини у about_bio дорівнює 2:
select * from about_bio_counter('Man at the Crossroads');



--Procedure
--кількість символів у короткому описі про задану картину

create or replace procedure CV_length(painting_name_ char(50)) 
language 'plpgsql' as 

$$

declare final_value  bio.short_biography%type;

	begin
		select length(trim(short_biography)) into final_value from bio 
			Inner join artist using(artist_id) Inner join the_most_famous_painting using(painting_id)
				where the_most_famous_painting.painting_name = painting_name_;
    				raise info 'Painting name: %,  final_value: %', painting_name_, final_value;
end;

$$

CALL CV_length('Reclining nude')


--Trigger

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

INSERT INTO artist VALUES (6, 'Rembrandt');
INSERT INTO artist VALUES (7, 'Michelangelo')
select * from artist
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




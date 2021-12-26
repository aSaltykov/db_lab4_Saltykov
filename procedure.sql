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

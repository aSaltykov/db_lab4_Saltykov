CREATE TABLE Artist (
  	artist_id int NOT NULL PRIMARY KEY,
	artist_name char(100)  NOT NULL
);

CREATE TABLE The_most_famous_painting (
  	 painting_id int NOT NULL PRIMARY KEY,
	 painting_name char(60)  NOT NULL
);


CREATE TABLE Genre (
  	genre_id int NOT NULL PRIMARY KEY,
	genre_name char(256) NOT NULL
	
);


CREATE TABLE Bio (
	about_bio char(100) UNIQUE PRIMARY KEY, 
	short_biography char(1000) NOT NULL,
	artist_id int NOT NULL,
	painting_id int NOT NULL,
	genre_id int NOT NULL,
	CONSTRAINT FK_Artist FOREIGN KEY(artist_id)
		REFERENCES Artist (artist_id) ON DELETE CASCADE,
	CONSTRAINT FK_The_most_famous_painting FOREIGN KEY (painting_id)
		REFERENCES The_most_famous_painting (painting_id) ON DELETE CASCADE,
	CONSTRAINT FK_Genre FOREIGN KEY (genre_id)
		REFERENCES Genre (genre_id) ON DELETE CASCADE
);
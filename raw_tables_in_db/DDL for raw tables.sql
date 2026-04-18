CREATE TABLE scooters_raw.events (
	user_id int8 NULL,
	"timestamp" timestamp NULL,
	type_id int8 NULL
);

CREATE TABLE scooters_raw.trips (
	id int8 NULL,
	user_id int8 NULL,
	scooter_hw_id varchar NULL,
	started_at timestamptz NULL,
	finished_at timestamptz NULL,
	start_lat float8 NULL,
	start_lon float8 NULL,
	finish_lat float8 NULL,
	finish_lon float8 NULL,
	distance float8 NULL,
	price int8 NULL
);

CREATE TABLE scooters_raw.users (
	id int8 NULL,
	first_name varchar NULL,
	last_name varchar NULL,
	phone varchar NULL,
	sex varchar NULL,
	birth_date date NULL
);

CREATE TABLE scooters_raw."version" (
	data_version varchar NULL,
	updated_at timestamptz NULL
);
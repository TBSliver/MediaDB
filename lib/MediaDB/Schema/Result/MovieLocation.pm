package MediaDB::Schema::Result::MovieLocation;

use DBIx::Class::Candy -autotable => v1;

unique_column movie_id => {
  data_type => 'int',
};

belongs_to(
  "movie",
  "MediaDB::Schema::Result::UserMovie",
  { "id" => 'movie_id' },
);

column location_id => {
  data_type => 'int',
};

belongs_to(
  "location",
  "MediaDB::Schema::Result::Location",
  { "id" => 'location_id' },
);

1;

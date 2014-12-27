package MediaDB::Schema::Result::UserMovie;

use DBIx::Class::Candy -autotable => v1;

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

column user_id => {
  data_type => 'int',
};

belongs_to(
  "user",
  "MediaDB::Schema::Result::User",
  { "id" => "user_id" },
);

column movie_id => {
  data_type => 'int',
};

belongs_to(
  "movie",
  "MediaDB::Schema::Result::Movie",
  { "id" => 'movie_id' },
);

might_have( 'location' => 'MediaDB::Schema::Result::MovieLocation', 'movie_id' );

1;
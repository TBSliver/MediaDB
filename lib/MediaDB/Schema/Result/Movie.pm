package MediaDB::Schema::Result::Movie;

use DBIx::Class::Candy -autotable => v1;

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

column title => {
  data_type => 'text',
};

has_one('owner' => 'MediaDB::Schema::Result::UserMovie', 'movie_id');
has_one('location' => 'MediaDB::Schema::Result::MovieLocation', 'movie_id');

1;

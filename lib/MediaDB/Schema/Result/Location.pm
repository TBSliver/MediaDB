package MediaDB::Schema::Result::Location;

use DBIx::Class::Candy -autotable => v1;

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

column name => {
  data_type => 'text',
};

column admin_id => {
  data_type => 'int',
};

belongs_to(
  "admin",
  "MediaDB::Schema::Result::User",
  { "id" => 'admin_id' },
);

has_many('movies' => 'MediaDB::Schema::Result::MovieLocation', 'location_id');
has_many('users' => 'MediaDB::Schema::Result::UserLocation', 'location_id');

1;

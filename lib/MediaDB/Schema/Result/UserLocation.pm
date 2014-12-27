package MediaDB::Schema::Result::UserLocation;

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
  { "id" => 'user_id' },
);

column location_id => {
  data_type => 'int',
};

belongs_to(
  "location",
  "MediaDB::Schema::Result::Location",
  { "id" => 'location_id' },
);

unique_constraint(
  [
    qw/ user_id location_id /
  ]
);

1;

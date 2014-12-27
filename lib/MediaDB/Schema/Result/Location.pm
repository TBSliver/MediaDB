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

sub add_user {
  my ( $self, $username ) = @_;

  my $user = $self->result_source->schema->resultset( 'User' )->find(
    {
      username => $username,
    }
  );

  $self->users->create(
    {
      user_id => $user->id,
    }
  );
}

sub add_movie {
  my ( $self, $movie_id ) = @_;

  $self->movies->create(
    {
      movie_id => $movie_id
    }
  );
}

1;

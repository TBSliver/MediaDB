package MediaDB::Schema::Result::User;

use DBIx::Class::Candy 
  -autotable => v1,
  -components => [ 'PassphraseColumn' ];

primary_column id => {
  data_type => 'int',
  is_auto_increment => 1,
};

unique_column username => {
  data_type => 'varchar',
  size => 25,
};

unique_column email => {
  data_type => 'varchar',
  size => 50,
};

column password => {
  data_type => 'varchar',
  size => 50,
  passphrase => 'crypt',
  passphrase_class => 'BlowfishCrypt',
  passphrase_args => {
    salt_random => 20,
    cost => 8,
  },
  passphrase_check_method => 'check_password',
};

column set_password_code => {
  data_type   => 'varchar',
  size        => 80,
  is_nullable => 1,
};

has_many('movies' => 'MediaDB::Schema::Result::UserMovie', 'user_id');
has_many('locations' => 'MediaDB::Schema::Result::UserLocation', 'user_id');
has_many('owned_locations' => 'MediaDB::Schema::Result::Location', 'admin_id');

sub add_movie {
  my ( $self, $title ) = @_;

  my $movie = $self->result_source->schema->resultset( 'Movie' )->find_or_create(
    {
      title => $title,
    }
  );

  my $new_movie = $self->movies->create(
    {
      movie_id => $movie->id,
    }
  );

  return $new_movie;
}

sub add_location {
  my ( $self, $name ) = @_;

  my $location = $self->result_source->schema->resultset( 'Location' )->create(
    {
      name => $name,
      admin_id => $self->id,
    }
  );

  $location->add_user( $self->username );

  return $location->id;
}

sub get_location {
  my ( $self, $location_id ) = @_;

  my $location = $self->owned_locations(
    {
      id => $location_id
    }
  )->first;

  return $location;
}

1;

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

  $self->movies->create(
    {
      movie_id => $movie->id,
    }
  );
}

1;

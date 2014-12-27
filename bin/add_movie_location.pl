#! /usr/bin/env perl

use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use MediaDB::Schema;
use Getopt::Long;

my $user     = undef;
my $movie    = undef;
my $location = undef;

GetOptions(
  'user=s'     => \$user,
  'movie=i'    => \$movie,
  'location=i' => \$location,
);

unless (
     defined $user
  && defined $movie
  && defined $location
) {
  die "Usage: add_user_movie --user <username> --movie <movie id> --location <location id>";
}

my @db_conn_info = ( "dbi:SQLite:$Bin/../mediadb.db" );

my $schema = MediaDB::Schema->connect( @db_conn_info );

my $user_obj = $schema->resultset( 'User' )->find(
  {
    username => $user
  }
);

die "No User by that name" unless $user_obj;

my $movie_obj = $user_obj->movies(
  {
    id => $movie
  }
)->first;

die "No Movie by that id" unless $movie_obj;

my $location_obj = $movie_obj->add_location( $location );

die "Location adding failed" unless $location_obj;

my $movie_name = $movie_obj->movie->title;
my $location_name = $location_obj->location->name;

print <<END;
Movie added to location:

  Owner:    $user
  Movie:    $movie_name
  Location: $location_name

END

#! /usr/bin/env perl

use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use MediaDB::Schema;
use Getopt::Long;

my $user = undef;

GetOptions(
  'user=s' => \$user,
);

unless (
  defined $user
) {
  die "Usage: print_user_movies.pl --user <username>";
}

my @db_conn_info = ( "dbi:SQLite:$Bin/../mediadb.db" );

my $schema = MediaDB::Schema->connect( @db_conn_info );

my $user_obj = $schema->resultset( 'User' )->find(
  {
    username => $user,
  }
);

my $user_id = $user_obj->id;
my $user_email = $user_obj->email;

print <<END;
Data for location:
  
  Username: $user
  Email:    $user_email
  ID:       $user_id

Owned Locations:
END

my $owned_locations_rs = $user_obj->owned_locations;
while( my $owned_location_r = $owned_locations_rs->next ) {
  print "  Name: " . $owned_location_r->name . "\n";
  print "  ID:   " . $owned_location_r->id . "\n";
}

print "\nAvailable Locations:\n";

my $locations_rs = $user_obj->locations;
while( my $location_r = $locations_rs->next ) {
  my $location_obj = $location_r->location;
  print "  Name: " . $location_obj->name . "\n";
  print "  ID:   " . $location_obj->id . "\n";
}

print "\nMovies:\n";

my $movies_rs = $user_obj->movies;
while( my $movie_r = $movies_rs->next ) {
  my $movie_obj = $movie_r->movie;
  print "  Title:     " . $movie_obj->title . "\n";
  print "  Movie ID:  " . $movie_obj->id . "\n";
  print "  Unique ID: " . $movie_r->id . "\n";
  my $location_obj = $movie_r->location;
  my $location_name = $location_obj ? $location_obj->location->name : "";
  print "  Location:  " . $location_name . "\n";
}

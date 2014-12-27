#! /usr/bin/env perl

use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use MediaDB::Schema;
use Getopt::Long;

my $location = undef;

GetOptions(
  'location=i' => \$location,
);

unless (
  defined $location
) {
  die "Usage: print_user_location.pl --location <location id>";
}

my @db_conn_info = ( "dbi:SQLite:$Bin/../mediadb.db" );

my $schema = MediaDB::Schema->connect( @db_conn_info );

my $location_obj = $schema->resultset( 'Location' )->find(
  {
    id => $location,
  }
);

my $admin_obj = $location_obj->admin;

my $location_name = $location_obj->name;

my $admin_name = $admin_obj->username;

print <<END;
Data for location:
  
  Admin: $admin_name
  Name:  $location_name
  ID:    $location

Users:
END

my $user_rs = $location_obj->users;
while( my $user_r = $user_rs->next ) {
  my $user_obj = $user_r->user;
  print "  Username: " . $user_obj->username . "\n";
  print "  Email:    " . $user_obj->email . "\n";
}

print "\nMovies:\n";

my $movie_rs = $location_obj->movies;
while( my $movie_r = $movie_rs->next ) {
  my $movie_obj = $movie_r->movie;
  print "  Movie: " . $movie_obj->movie->title . "\n";
  print "  Owner: " . $movie_r->movie->user->username . "\n";
}


#! /usr/bin/env perl

use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use MediaDB::Schema;
use Getopt::Long;

my $user  = undef;
my $movie = undef;

GetOptions(
  'user=s'  => \$user,
  'movie=s' => \$movie,
);

unless (
     defined $user
  && defined $movie
) {
  die "You must define user and movie arguments"
}

my @db_conn_info = ( "dbi:SQLite:$Bin/../mediadb.db" );

my $schema = MediaDB::Schema->connect( @db_conn_info );

my $movie_user = $schema->resultset( 'User' )->find(
  {
    username => $user
  }
);

die "Must be an actual user" unless $movie_user;

$movie_user->add_movie( $movie );

print <<END;
Movie added with the following details:

  User:        $user
  Movie Title: $movie

END

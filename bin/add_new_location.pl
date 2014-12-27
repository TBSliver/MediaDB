#! /usr/bin/env perl

use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use MediaDB::Schema;
use Getopt::Long;

my $user     = undef;
my $location = undef;

GetOptions(
  'user=s'     => \$user,
  'location=s' => \$location,
);

unless (
     defined $user
  && defined $location
) {
  die "Usage: add_new_location.pl --user <username> --location <location name>";
}

my @db_conn_info = ( "dbi:SQLite:$Bin/../mediadb.db" );

my $schema = MediaDB::Schema->connect( @db_conn_info );

my $location_user = $schema->resultset( 'User' )->find(
  {
    username => $user
  }
);

die "Must be an actual user" unless $location_user;

my $location_id = $location_user->add_location( $location );

print <<END;
The following location has been added:

  Admin User: $user
  Location:   $location
  Location Id: $location_id

END

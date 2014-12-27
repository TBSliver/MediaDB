#! /usr/bin/env perl

use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use MediaDB::Schema;
use Getopt::Long;

my $admin    = undef;
my $user     = undef;
my $location = undef;

GetOptions(
  'admin=s'    => \$admin,
  'user=s'     => \$user,
  'location=i' => \$location,
);

unless (
     defined $admin
  && defined $user
  && defined $location
) {
  die "Usage: add_user_location.pl --admin <admin username> --user <username> --location <location id>";
}

my @db_conn_info = ( "dbi:SQLite:$Bin/../mediadb.db" );

my $schema = MediaDB::Schema->connect( @db_conn_info );

my $admin_user = $schema->resultset( 'User' )->find(
  {
    username => $admin
  }
);

die "Admin must be an actual user" unless $admin_user;

my $location_user = $schema->resultset( 'User' )->find(
  {
    username => $user
  }
);

die "Must be an actual user" unless $location_user;

my $location_obj = $admin_user->get_location( $location );

die "Admin must own the location" unless $location_obj;

use Data::Dumper;

$location_obj->add_user( $user );

print <<END;
The following location has been added:

  Admin User: $admin
  Location:   $location
  New User:   $user

END

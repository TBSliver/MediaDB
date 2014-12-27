#! /usr/bin/env perl

use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use MediaDB::Schema;
use Getopt::Long;

my $user     = undef;
my $email    = undef;
my $password = undef;

GetOptions(
  'user=s'     => \$user,
  'email=s'    => \$email,
  'password=s' => \$password,
);

unless (
     defined $user 
  && defined $email
  && defined $password
) {
  die "You must define all 3 arguments"
}

my @db_conn_info = ( "dbi:SQLite:$Bin/../mediadb.db" );

my $schema = MediaDB::Schema->connect( @db_conn_info );

my $test_username = $schema->resultset( 'User' )->find(
  {
    username => $user,
  }
);

my $test_email = $schema->resultset( 'User' )->find(
  {
    email => $email,
  }
);

die "User already exists" if $test_username;
die "Email already exists" if $test_email;

$schema->resultset( 'User' )->create(
  {
    username => $user,
    email => $email,
    password => $password,
  }
);

print <<END;
The user has been created with the following details:

  Username: $user
  Email:    $email
  Password: $password

END

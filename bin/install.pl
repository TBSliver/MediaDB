#! /usr/bin/env perl

use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use DBIx::Class::DeploymentHandler;
use MediaDB::Schema;
use Getopt::Long;

my $setup = 0;
my $install = 0;
my $force_overwrite = 0;
my $drop_tables = 0;
my $db_version = 0;
GetOptions(
  'setup'           => \$setup,
  'install'         => \$install,
  'force_overwrite' => \$force_overwrite,
  'drop_tables'     => \$drop_tables,
  'version=i'       => \$db_version,
);

my @db_conn_info = ( "dbi:SQLite:$Bin/../mediadb.db" );

my $schema = MediaDB::Schema->connect( @db_conn_info );

my $dh = DBIx::Class::DeploymentHandler->new({
  schema           => $schema,
  script_directory => "$Bin/../dbicdh",
  databases        => 'SQLite',
  force_overwrite  => $force_overwrite,
});

if( $setup ) {
  $dh->prepare_install;
}

if( $install ) {
  if ( $db_version ) {
    $dh->install({ version => $db_version });
  } else {
    $dh->install;
  }
}

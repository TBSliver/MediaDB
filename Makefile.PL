#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'MediaDB-Web';
all_from 'lib/MediaDB/Web.pm';

requires 'Catalyst::Runtime' => '5.90075';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats

requires 'DBIx::Class';
requires 'DBIx::Class::Candy';
requires 'DBIx::Class::PassphraseColumn';
requires 'Catalyst::Plugin::Authentication';
requires 'Authen::Passphrase::BlowfishCrypt';
requires 'Catalyst::Authentication::Store::DBIx::Class';
requires 'DBIx::Class::DeploymentHandler';
requires 'Catalyst::View::JSON';
requires 'JSON::MaybeXS';
requires 'Cpanel::JSON::XS';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::View::Email::Template';
requires 'Catalyst::View::TT';


test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;

package MediaDB::Web;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
  -Debug
  ConfigLoader
  Static::Simple
  Authentication
  Session
  Session::Store::FastMmap
  Session::State::Cookie
/;

extends 'Catalyst';

our $VERSION = '0.001';

# Configure the application.
#
# Note that settings in mediadb_web.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
  name => 'MediaDB::Web',
  # Disable deprecated behavior needed by old applications
  disable_component_resolution_regex_fallback => 1,
  enable_catalyst_header => 1, # Send X-Catalyst header

  'Plugin::Static::Simple' => {
    ignore_extensions => [ qw/tt tt2/ ],
    dirs => [
      'static',
    ]
  },

  'Plugin::Authentication' => {
    default_realm => 'people',
    people  => {
      credential => {
        class => 'Password',
        password_field => 'password',
        password_type  => 'self_check',
      },
      store => {
        class => 'DBIx::Class',
        user_model => 'DB::User',
      },
    },
  },

  'View::JSON' => {
    expose_stash => [ qw/ data success message / ],
  },
);

# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

MediaDB::Web - Catalyst based application

=head1 SYNOPSIS

    script/mediadb_web_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<MediaDB::Web::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Tom Bloor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

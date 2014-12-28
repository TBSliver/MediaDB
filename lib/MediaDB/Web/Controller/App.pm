package MediaDB::Web::Controller::App;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MediaDB::Web::Controller::App - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  if ( $c->user_exists ) {
    $c->serve_static_file(
      $c->path_to('root', 'static', 'ui', 'index.html')
    );
  } else {
    $c->res->redirect( $c->uri_for( '/login' ) );
  }
}

sub logout :Local {
  my ( $self, $c ) = @_;

  $c->logout;
  $c->res->redirect( $c->uri_for( '/login' ) );
}

=encoding utf8

=head1 AUTHOR

Tom Bloor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

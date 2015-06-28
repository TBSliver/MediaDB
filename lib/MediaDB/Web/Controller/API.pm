package MediaDB::Web::Controller::API;
use Moose;
use namespace::autoclean;
use JSON::MaybeXS qw/ JSON /;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MediaDB::Web::Controller::API - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

sub auto :Private {
  my ( $self, $c ) = @_;

  unless ( $c->user_exists ) {
    $c->stash->{ success } = JSON->true;
    $c->stash->{ messages } = 'not logged in';

    $c->detach( 'View::JSON' );
  }
}

=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  $c->stash->{ success } = JSON->true;
  $c->stash->{ messages } = 'success';

}

sub end :Private {
  my ( $self, $c ) = @_;

  $c->detach( 'View::JSON' );
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

package MediaDB::Web::Controller::API::User;
use Moose;
use namespace::autoclean;
use JSON::MaybeXS qw/ JSON /;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MediaDB::Web::Controller::API::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  my $user = $c->user;

  $c->stash->{ data } = {
    username => $user->username,
    email => $user->email,
  };

  $c->stash->{ status } = 200;
}

sub change_pass :Local {
  my ( $self, $c ) = @_;

  my $user = $c->user;
  
  my $password_old = $c->request->body_data->{password_old};
  my $password_new = $c->request->body_data->{password_new};

  if ( $user->check_password( $password_old ) ) {
    $user->password( $password_new );
    $user->update;
    $user->discard_changes;

    $c->stash->{data} = { success => JSON->true };
  } else {
    $c->stash->{data} = { success => JSON->false };
  }

  $c->stash->{ status } = 200;
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

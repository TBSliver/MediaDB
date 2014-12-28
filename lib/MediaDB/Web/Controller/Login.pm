package MediaDB::Web::Controller::Login;
use Moose;
use namespace::autoclean;
use JSON::MaybeXS qw/ JSON /;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MediaDB::Web::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  $c->serve_static_file(
    $c->path_to('root', 'static', 'login', 'index.html')
  );
}

sub do :Local {
  my ($self, $c ) = @_;

  my $username = $c->request->body_data->{username};
  my $password = $c->request->body_data->{password};

  if ($c->authenticate({ username => $username, password => $password })) {
    # Remove set password code on successful login
    $c->user->set_password_code(undef);
    $c->user->update;

    $c->stash->{data} = {
      success  => JSON->true,
      redirect => "/app",
    };
    $c->forward('View::JSON');
  } else {
    $c->stash->{data} = { success => JSON->false };
    $c->forward('View::JSON');
  }

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

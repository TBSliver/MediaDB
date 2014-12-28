package MediaDB::Web::Controller::Login;
use Moose;
use namespace::autoclean;
use String::Random qw(random_regex);
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

sub reset_password :Local {
  my ( $self, $c ) = @_;

  my $email = $c->request->body_data->{email};

  my $user = $c->model('DB::User')->find(
    {
      email => $email
    }
  );

  if ($user) {
    my $code = random_regex('\w{64}');

    $user->set_password_code($code);
    $user->update;
    $user->discard_changes;

    $c->stash->{set_password_code} = $code;
    $c->stash->{portal_addr}       = $c->uri_for('/');

    $c->stash->{email} = {
      to           => $user->email,
      from         => $c->config->{email}->{from_address},
      subject      => "Password reset for MediaDB",
      template     => 'forgot_password.tt',
    };

    $c->log->info( "Password set code for " . $user->username . " : " . $code );

    $c->stash->{data} = { success => JSON->true };

    $c->forward('View::Email');
  }

  $c->detach('View::JSON');
}

sub set_password :Local {
  my ( $self, $c ) = @_;

  my $code = $c->request->body_data->{set_password_code};
  my $password = $c->request->body_data->{password};

  my $user = $c->model('DB::User')->find(
    {
      set_password_code => $code
    }
  );

  if ($user) {
    $user->password($password);
    $user->set_password_code(undef);
    $user->update;

    $c->authenticate({ username => $user->username, password => $password });

    $c->stash->{data} = {
      success => JSON->true,
      redirect => '/app',
    };
  } else {
    $c->stash->{data} = { success => JSON->false };
  }

  $c->detach('View::JSON');
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

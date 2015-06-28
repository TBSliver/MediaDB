package MediaDB::Web::Controller::API::Location;
use Moose;
use namespace::autoclean;
use JSON::MaybeXS qw/ JSON /;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MediaDB::Web::Controller::API::Location - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  my $user = $c->user;

  my $avail_location_rs = $user->locations;

  my @user_locations;

  while( my $location_rs = $avail_location_rs->next ) {
    my $single_user_location = {
      name => $location_rs->location->name,
      id => $location_rs->location->id,
      user_count => $location_rs->location->users->count,
      is_admin => $location_rs->location->admin->id == $user->id ?
        JSON->true : JSON->false,
    };
    push @user_locations, $single_user_location;
  }

  $c->stash->{ data } = {
    locations => \@user_locations,
  };

  $c->stash->{ success } = JSON->true;
}

sub by_id :Local {
  my ( $self, $c ) = @_;

  my $avail_location_rs = $c->user->locations;

  my %locations;

  while ( my $location_rs = $avail_location_rs->next ) {
    $locations{ $location_rs->id } = {
      name => $location_rs->location->name,
      is_admin => $location_rs->location->admin->id == $c->user->id ?
        JSON->true : JSON->false,
    };
  }

  $c->stash->{ data } = {
    locations => \%locations,
  };

  $c->stash->{ success } = JSON->true;
}

sub add :Local {
  my ( $self, $c ) = @_;
  
  my $location_name = $c->request->body_data->{ name };

  unless ( $location_name ) {
    $c->stash->{ success } = JSON->false;
    $c->stash->{ message } = "Location Name Cannot Be Empty";
  } else {
    my $location_id = $c->user->add_location( $location_name );

    $c->stash->{ data } = {
      location_id => $location_id,
    };

    $c->stash->{ success } = JSON->true;
  }
}

sub get :Local {
  my ( $self, $c ) = @_;

  my $location_id = $c->request->body_data->{ id };

  my $location_rs = $c->user->owned_locations->find({
    id => $location_id,
  });

  $c->stash->{ data } = {
    location => {
      id => $location_rs->id,
      name => $location_rs->name,
    }
  };
  $c->stash->{ success } = JSON->true;
}

sub edit :Local {
  my ( $self, $c ) = @_;

  my $location_id = $c->request->body_data->{ id };
  my $location_name = $c->request->body_data->{ name };

  my $location_rs = $c->user->locations->find({
    id => $location_id,
  });

  $location_rs->location->update({
    name => $location_name,
  });

  $c->stash->{ success } = JSON->true;
  $c->stash->{ message } = "Location Name changed Successfully";
}

sub delete :Local {
  my ( $self, $c ) = @_;

  my $location_id = $c->request->body_data->{ id };

  my $location_rs = $c->user->owned_locations->find({
    id => $location_id,
  });

  my $location_movies = $location_rs->movies;

  while ( my $movie = $location_movies->next ) {
    if ( defined $movie->location ) {
      $movie->location->delete;
    }
  }

  $location_rs->delete;

  $c->stash->{ success } = JSON->true;
  $c->stash->{ message } = "Location Deleted Successfully";
}

sub add_user :Local {
  my ( $self, $c ) = @_;

  my $location_id = $c->request->body_data->{ location_id };
  my $new_user = $c->request->body_data->{ username };

  my $location = $c->user->get_location( $location_id );
  $location->add_user( $new_user );

  $c->stash->{ success } = JSON->true;
  $c->stash->{ message } = sprintf(
    "%s added to %s",
    $new_user,
    $location->name
  );
}

=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

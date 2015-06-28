package MediaDB::Web::Controller::API::Movie;
use Moose;
use namespace::autoclean;
use JSON::MaybeXS qw/ JSON /;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MediaDB::Web::Controller::API::Movie - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  my $movies_rs = $c->user->movies;

  my @movies;

  while ( my $movie_rs = $movies_rs->next ) {
    my $single_movie = {
      title => $movie_rs->movie->title,
      id => $movie_rs->id,
      location => $movie_rs->location ?
        {
          id => $movie_rs->location->location->id,
          name => $movie_rs->location->location->name,
        } : {},
    };

    push @movies, $single_movie;
  }

  $c->stash->{ data } = {
    movies => \@movies,
  };

  $c->stash->{ success } = JSON->true;
}

sub add :Local {
  my ( $self, $c ) = @_;

  my $movie_name = $c->request->body_data->{ title };
  my $location_id = $c->request->body_data->{ location };

  my $new_movie = $c->user->add_movie( $movie_name );
  $new_movie->add_location( $location_id ) if $location_id;

  $c->stash->{ success } = JSON->true;
  $c->stash->{ message } = "New Movie Added Successfully";
}

sub get :Local {
  my ( $self, $c ) = @_;

  my $movie_id = $c->request->body_data->{ id };

  my $movie_rs = $c->user->movies->find({
    id => $movie_id,
  });

  $c->stash->{ data } = {
    movie => {
      title => $movie_rs->movie->title,
      id => $movie_rs->id,
      location => $movie_rs->location ? $movie_rs->location->location->id : undef,
    }
  };
  $c->stash->{ success } = JSON->true;
}

sub edit :Local {
  my ( $self, $c ) = @_;

  my $movie_id = $c->request->body_data->{ id };
  my $movie_title = $c->request->body_data->{ title };
  my $movie_location = $c->request->body_data->{ location };

  my $movie_rs = $c->user->movies->find({
    id => $movie_id,
  });

  if ( defined $movie_rs->location ) {
    $movie_rs->location->delete;
  }
  $movie_rs->add_location( $movie_location );

  unless ( $movie_title eq $movie_rs->movie->title ) {
    my $main_movie = $c->model("DB::Movie")->find_or_create({
      title => $movie_title,
    });
    $movie_rs->update({
      movie_id => $main_movie->id,
    });
  }

  $c->stash->{ success } = JSON->true;
  $c->stash->{ message } = "Movie Updated Successfully";

}

sub delete :Local {
  my ( $self, $c ) = @_;

  my $movie_id = $c->request->body_data->{ id };

  $c->user->movies->find({
    id => $movie_id,
  })->delete;

  $c->stash->{ success } = JSON->true;
  $c->stash->{ message } = "Movie Deleted Successfully";
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

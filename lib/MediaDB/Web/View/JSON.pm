package MediaDB::Web::View::JSON;

use JSON::MaybeXS qw/ JSON /;
use Moose;
use MooseX::AttributeShortcuts;

extends 'Catalyst::View::JSON';

has json_object => (
  is => 'lazy',
  builder => sub {
    return JSON->new->utf8->pretty(0)->indent(0)
          ->allow_blessed(1)->convert_blessed(1);
  },
);

sub encode_json {
  my ( $self, $c, $data ) = @_;

  return $self->json_object->encode( $data );
}

1;

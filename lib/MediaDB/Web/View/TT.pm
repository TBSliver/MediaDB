package MediaDB::Web::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

MediaDB::Web::View::TT - TT View for MediaDB::Web

=head1 DESCRIPTION

TT View for MediaDB::Web.

=head1 SEE ALSO

L<MediaDB::Web>

=head1 AUTHOR

Tom Bloor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

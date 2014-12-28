package MediaDB::Web::View::Email;

use strict;
use base 'Catalyst::View::Email::Template';

__PACKAGE__->config(
    stash_key       => 'email',
    template_prefix => 'src/email',
    default         => {
      charset      => 'UTF-8',
      view         => 'TT',
      content_type => 'text/html',
    }
);

=head1 NAME

MediaDB::Web::View::Email - Templated Email View for MediaDB::Web

=head1 DESCRIPTION

View for sending template-generated email from MediaDB::Web. 

=head1 AUTHOR

Tom Bloor,,,

=head1 SEE ALSO

L<MediaDB::Web>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

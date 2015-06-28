use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MediaDB::Web';
use MediaDB::Web::Controller::API::Location;

ok( request('/api/location')->is_success, 'Request should succeed' );
done_testing();

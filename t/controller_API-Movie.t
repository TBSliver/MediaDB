use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MediaDB::Web';
use MediaDB::Web::Controller::API::Movie;

ok( request('/api/movie')->is_success, 'Request should succeed' );
done_testing();

use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MediaDB::Web';
use MediaDB::Web::Controller::API::User;

ok( request('/api/user')->is_success, 'Request should succeed' );
done_testing();

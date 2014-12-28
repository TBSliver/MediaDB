use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MediaDB::Web';
use MediaDB::Web::Controller::App;

ok( request('/app')->is_success, 'Request should succeed' );
done_testing();

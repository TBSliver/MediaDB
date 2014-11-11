use strict;
use warnings;

use MediaDB::Web;

my $app = MediaDB::Web->apply_default_middlewares(MediaDB::Web->psgi_app);
$app;


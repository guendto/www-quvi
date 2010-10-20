
use warnings;
use strict;

use Test::More;

$ENV{HAVE_INTERNET}
    ? plan tests => 16
    : plan skip_all => 'Set HAVE_INTERNET to enable these tests';

use_ok('WWW::Quvi');

my $opts = new WWW::Quvi::Options;

my $q = new WWW::Quvi::Query;
isa_ok ($q, 'WWW::Quvi::Query');

my $url =
"http://www.funnyordie.com/videos/eec0f64fc5/between-two-ferns-with-zach-galifianakis-bruce-willis";

my $v = $q->parse ($url, $opts);
isa_ok ($v, 'WWW::Quvi::Video');

is ($v->{ok},    1);
is ($v->{title}, "Between Two Ferns with Zach Galifianakis: Bruce Willis");
is ($v->{url},   $url);
is ($v->{host},  "funnyordie");
is ($v->{id},    "eec0f64fc5");
is ($v->{link}->{url}, "http://videos0.ordienetworks.com/videos/eec0f64fc5/iphone_wifi.mp4");
is ($v->{link}->{content_type}, "video/mp4");
is ($v->{link}->{length_bytes}, 16235486);
is ($v->{link}->{file_suffix},  "mp4");

is ($q->{resp_code}, 200);
is ($q->{quvi_code},   0);

$opts->{http_proxy} = "http://localhost:1234";

# Should fail. Assumes localhost isn't running an HTTP proxy at 1234.
$v = $q->parse ($url, $opts);
isa_ok ($v,       "WWW::Quvi::Video");
is     ($v->{ok}, ""); 

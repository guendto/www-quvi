
use warnings;
use strict;

use Test::More tests => 40;
BEGIN { use_ok('WWW::Quvi') };

# Version.

like (&WWW::Quvi::version, qr{^\d+.\d+$});

like (&WWW::Quvi::version(WWW::Quvi::ModuleVersion), qr{^\d+.\d+$});

like (
    &WWW::Quvi::version(WWW::Quvi::libquviVersion), qr{^\d+.\d+.\d+$});

like (
    &WWW::Quvi::version(WWW::Quvi::libquviVersionLong),
    qr{^\d+.\d+.\d+.* built on \d+.\d+.\d+ .* (.*)$}
);

# Options.

my $opts = new WWW::Quvi::Options;
isa_ok ($opts, 'WWW::Quvi::Options');

is ($opts->{user_agent}, "");
is ($opts->{http_proxy}, "");
is ($opts->{format},     "default");
is ($opts->{verify},     1);
is ($opts->{verbose_libcurl}, "");
is ($opts->{shortened},  1);
is ($opts->{category},   WWW::Quvi::ProtoHttp);

$opts->{user_agent} = "Mozilla/5.0";
is ($opts->{user_agent}, "Mozilla/5.0");

$opts->{http_proxy} = "http://foo:1234";
is ($opts->{http_proxy}, "http://foo:1234");

$opts->{format} = "hd";
is ($opts->{format}, "hd");

$opts->{verify} = 0;
is ($opts->{verify}, "");

$opts->{verbose_libcurl} = 1;
is ($opts->{verbose_libcurl}, 1);

$opts->{shortened} = 0;
is ($opts->{shortened}, "");

$opts->{category} = WWW::Quvi::ProtoMms;
is ($opts->{category}, WWW::Quvi::ProtoMms);

# Link.

my $l = new WWW::Quvi::Link;
isa_ok ($l, 'WWW::Quvi::Link');

is ($l->{content_type}, "");
is ($l->{file_suffix},  "");
is ($l->{length_bytes}, -1);
is ($l->{url},          "");

# Video.

my $v = new WWW::Quvi::Video;
isa_ok ($v, 'WWW::Quvi::Video');

is ($v->{title},      "");
is ($v->{host},       "");
is ($v->{url},        "");
is ($v->{id},         "");
is ($v->{ok},         "");
is ($v->{start_time}, "");

# Query.

my $q = new WWW::Quvi::Query;
isa_ok ($q, 'WWW::Quvi::Query');

is ($q->{last_error}, "");
is ($q->{quvi_code},   0);
is ($q->{resp_code},  -1);

# Websites.

my ($rc, $domain, $formats) = $q->next_website;
is ($rc, WWW::Quvi::OK);
like ($domain, qr{^\w+.\w+$});
like ($formats, qr{^\w+(?:|)});

# Supported.

$rc = $q->supported ("http://dai.ly");
is ($rc, WWW::Quvi::OK);

# QUVIcode aliases.

my @QUVIcode = {
   WWW::Quvi::OK,
   WWW::Quvi::Mem,
   WWW::Quvi::BadHandle,
   WWW::Quvi::InvArg,
   WWW::Quvi::CurlInit,
   WWW::Quvi::Last,
   WWW::Quvi::AbortedByCallback,
   WWW::Quvi::LuaInit,
   WWW::Quvi::NoLuaWebsite,
   WWW::Quvi::NoSupport,
   WWW::Quvi::CallbackError,
   WWW::Quvi::IconvError,
   WWW::Quvi::LuaError,
};

# QUVIcategory aliases.

my @QUVIcategory = {
   WWW::Quvi::ProtoHttp,
   WWW::Quvi::ProtoMms,
   WWW::Quvi::ProtoRtsp,
   WWW::Quvi::ProtoRtmp,
   WWW::Quvi::ProtoAll,
0xffff # Pad to prevent "Odd number of elements in anonymous hash" warning
};

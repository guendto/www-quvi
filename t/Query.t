
# WWW::Quvi
# Copyright (C) 2011  Toni Gundogdu <legatvs@gmail.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
#

use warnings;
use strict;

use Test::More;
use WWW::Quvi;

$ENV{HAVE_INTERNET}
  ? plan tests => 2
  : plan skip_all => 'Set HAVE_INTERNET to enable';

use constant URL =>
  "http://www.dailymotion.com/video/xdpig1_city-of-scars_shortfilms";

my $o = new WWW::Quvi::Options;
my $q = new WWW::Quvi::Query;
$q->set_opts($o);

# Formats.

my ($rc, $fmts) = $q->formats(URL);
is($rc, WWW::Quvi::OK) or diag $q->{last_error};
#diag $fmts;

# Media.

my $m = $q->parse(URL);
is($m->{ok}, 1) or diag $q->{last_error};

# vim: set ts=2 sw=2 tw=72 expandtab:

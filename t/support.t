
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

use Test::More tests => 3;
use WWW::Quvi;

my $q = new WWW::Quvi::Query;
$q->set_opts(new WWW::Quvi::Options);

# Next (supported) website.

my $n=0;
while (1) {
  my ($done) = $q->next_website;
  last if $done;
  ++$n;
}
isnt($n, 0);
#diag $n;

# Supported.

my $rc = $q->supported('http://dai.ly/foobar');
is($rc, WWW::Quvi::OK);

$rc = $q->supported('http://foo.bar');
is($rc, WWW::Quvi::NoSupport);

# vim: set ts=2 sw=2 tw=72 expandtab:

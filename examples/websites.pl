#!/usr/bin/env perl
#
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

# websites.pl

use warnings;
use strict;

use Carp qw(croak);
use WWW::Quvi;

my $q = new WWW::Quvi::Query;
=for comment
my $o = new WWW::Quvi::Options;
$o->{category} = WWW::Quvi::ProtoRtmp;
$q->set_opts($o);
=cut

# The returned formats (f) has no real use since libquvi 0.2.17.
# Query::next_website function is suitable for only listing the
# supported  websites. If you want to know which formats are
# available to an URL use the Query::formats instead.

while ($q->{ok}) {
  my ($d,$f) = $q->next_website;
  printf "%32s : %s\n", $d, $f if $q->{ok};
}

# vim: set ts=2 sw=2 tw=72 expandtab:

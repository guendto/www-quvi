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

# support.pl - Check whether URL (arg0) is supported

# Query::supported  will return NoSupport for most shortened
# (or compressed) URLs. Use Query::parse instead if your
# application must support shortened URLs.

use WWW::Quvi;

scalar @ARGV || usage();

my $q = new WWW::Quvi::Query;

printf "%s : %s\n",
  $ARGV[0], $q->supported($ARGV[0]) == WWW::Quvi::OK
  ? "Yes"
  : "No";

sub usage()
{
  print "usage: $0 [URL]\n";
  exit 0;
}

# vim: set ts=2 sw=2 tw=72 expandtab:

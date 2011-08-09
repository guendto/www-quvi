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

# query_media.pl

use warnings;
use strict;

use Carp qw(croak);
use WWW::Quvi;

use constant URL =>
  "http://www.dailymotion.com/video/xdpig1_city-of-scars_shortfilms";

my $q = new WWW::Quvi::Query;

# Query media.

my $m = $q->parse(URL);
croak "error: $q->{errmsg}\n" unless $q->{ok};

printf "%10s : %s : %s
  %10s : %s : %d bytes
  %s
",
  $m->{page_title},
  $m->{id},
  $m->{host},
  $m->{content_type},
  $m->{file_suffix},
  $m->{content_length},
  $m->{url};

# vim: set ts=2 sw=2 tw=72 expandtab:

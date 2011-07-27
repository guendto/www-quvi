
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

my %h = (
  start_time    => '',
  page_url      => '',
  page_title    => '',
  host          => '',
  id            => '',
  ok            => 0,
  content_length=> -1,
  content_type  => '',
  file_suffix   => '',
  url           => '',
  thumbnail_url => '',
  duration      => -1
);

plan tests => keys(%h) + 1;

my $m = new WWW::Quvi::Media;
isa_ok($m, 'WWW::Quvi::Media');

for my $k (keys %h) {
  is($m->{$k}, $h{$k}); # Test default.
}

# vim: set ts=2 sw=2 tw=72 expandtab:


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

my @return = (
              WWW::Quvi::OK,                WWW::Quvi::Mem,
              WWW::Quvi::BadHandle,         WWW::Quvi::InvArg,
              WWW::Quvi::CurlInit,          WWW::Quvi::Last,
              WWW::Quvi::AbortedByCallback, WWW::Quvi::LuaInit,
              WWW::Quvi::NoLuaWebsite,      WWW::Quvi::NoLuaUtil,
              WWW::Quvi::NoSupport,         WWW::Quvi::CallbackError,
              WWW::Quvi::IconvError,        WWW::Quvi::LuaError
             );

my @proto = (
             WWW::Quvi::ProtoHttp, WWW::Quvi::ProtoMms,
             WWW::Quvi::ProtoRtsp, WWW::Quvi::ProtoRtmp,
             WWW::Quvi::ProtoAll
            );

plan tests => scalar @return + scalar @proto;

my $n = -1;
foreach (@return)
{
  is($_, ++$n);

  #  diag "$_,$n\n";
  $n = 0x40 if $n == WWW::Quvi::NoLuaUtil;
}

$n = 1;
foreach (@proto)
{
  is($_, $n);

  #  diag "$_,$n\n";
  if ($n == WWW::Quvi::ProtoRtmp)
  {
    $n = 0x1 | 0x2 | 0x4 | 0x8;
  }
  else
  {
    $n = $n << 1;
  }
}

# vim: set ts=2 sw=2 tw=72 expandtab:

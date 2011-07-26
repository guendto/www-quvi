#!/bin/sh

# WWW::Quvi
# Copyright (C) 2010, 2011  Toni Gundogdu <legatvs@gmail.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301  USA

wrap="Quvi_wrap.cxx"
pod="doc/Quvi.pod"
dest="lib/WWW/"
i="i/Quvi.i"

cleanup()
{
  [ -e Makefile ] && make distclean
  rm -rf lib/ ; rm -f $wrap
  exit 0
}

help()
{
  echo "Usage: $0 [-c|-h]
-h  Show this help and exit
-c  Make the source tree 'maintainer clean'
Run without options to (re)generate the configuration files."
  exit 0
}

while [ $# -gt 0 ]
do
  case "$1" in
    -c) cleanup;;
    -h) help;;
    *) break;;
  esac
  shift
done

echo "Generate configuration files..."

mkdir -p $dest \
&& echo "$i -> $dest..." \
&& swig -c++ -const -perl5 -I/usr/include $quvi_CFLAGS \
    -outdir $dest -o $wrap $i \
&& echo "cp $pod -> $dest..." \
&& cp $pod $dest

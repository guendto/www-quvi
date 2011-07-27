/* WWW::Quvi
 * Copyright (C) 2010-2011  Toni Gundogdu <legatvs@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301  USA
 */

#include <string>

#include "Quvi.h"

#define _init \
: user_agent(""), \
  http_proxy(""), \
  verbose_libcurl(0), \
  format("default"), \
  category(QUVIPROTO_ALL), \
  resolve(1), \
  verify(1)

Options::Options()
_init
{
}

Options::Options(const Options& o)
_init
{
  _swap(o);
}

#undef _init

Options& Options::operator=(const Options& o)
{
  if (this != &o) _swap(o);
  return *this;
}

Options::~Options()
{
}

void Options::_swap(const Options& o)
{
  verbose_libcurl = o.verbose_libcurl;
  user_agent      = o.user_agent;
  http_proxy      = o.http_proxy;
  format          = o.format;
  verify          = o.verify;
  resolve         = o.resolve;
  category        = o.category;
}

// vim: set ts=2 sw=2 tw=72 expandtab:

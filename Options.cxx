/*
* Copyright (C) 2010 Toni Gundogdu.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <string>

#include "Quvi.h"

Options::Options ()
  :verbose_libcurl (false), format ("default"), verify (true),
   shortened(true), category(QUVIPROTO_HTTP) { }

Options::Options (const Options& o)
  :verbose_libcurl (false), format ("default"), verify (true),
   shortened(true), category(QUVIPROTO_HTTP)
{
  _swap (o);
}

Options&
Options::operator=(const Options& o)
{
  if (this != &o) _swap (o);
  return *this;
}

Options::~Options () { }

void
Options::_swap (const Options& o)
{
  verbose_libcurl = o.verbose_libcurl;
  user_agent      = o.user_agent;
  http_proxy      = o.http_proxy;
  format          = o.format;
  verify          = o.verify;
  shortened       = o.shortened;
  category        = o.category;
}



/* WWW::Quvi
 * Copyright (C) 2010,2011  Toni Gundogdu <legatvs@gmail.com>
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

Media::Media()
  : ok(false)
{
}

Media::Media(quvi_media_t m)
  : ok(true)
{
#define _wrap(id,dst,type) \
    do { type t; quvi_getprop(m,id,&t); dst=t; } while (0)
  _wrap(QUVIPROP_HOSTID,      host,       char*);
  _wrap(QUVIPROP_PAGEURL,     page_url,   char*);
  _wrap(QUVIPROP_PAGETITLE,   title,      char*);
  _wrap(QUVIPROP_MEDIAID,     id,         char*);
  _wrap(QUVIPROP_STARTTIME,   start_time, char*);
#undef _wrap
  url = Url(m);
  quvi_parse_close(&m);
}

Media::Media(const Media& v)
  :ok(false)
{
  _swap(v);
}

Media& Media::operator=(const Media& v)
{
  if (this != &v) _swap(v);
  return *this;
}

Media::~Media()
{
}

void Media::_swap(const Media& v)
{
  title       = v.title;
  host        = v.host;
  page_url    = v.page_url;
  id          = v.id;
  url         = v.url;
  ok          = v.ok;
  start_time  = v.start_time;
}

// vim: set ts=2 sw=2 tw=72 expandtab:

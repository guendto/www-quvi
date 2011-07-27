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
 : content_length(-1), duration(-1)

Media::Media()
_init
{
}

Media::Media(quvi_media_t m)
_init
{
#define _wrap(id,dst,type) \
    do { type t; quvi_getprop(m,id,&t); dst=t; } while (0)
  _wrap(QUVIPROP_PAGETITLE,   page_title, char*);
  _wrap(QUVIPROP_STARTTIME,   start_time, char*);
  _wrap(QUVIPROP_PAGEURL,     page_url,   char*);
  _wrap(QUVIPROP_HOSTID,      host,       char*);
  _wrap(QUVIPROP_MEDIAID,     id,         char*);
  _wrap(QUVIPROP_MEDIACONTENTLENGTH, content_length, double);
  _wrap(QUVIPROP_MEDIACONTENTTYPE, content_type, char*);
  _wrap(QUVIPROP_FILESUFFIX,  file_suffix,   char*);
  _wrap(QUVIPROP_MEDIAURL,    url,           char*);
  _wrap(QUVIPROP_MEDIATHUMBNAILURL, thumbnail_url, char*);
  _wrap(QUVIPROP_MEDIADURATION, duration, double);
#undef _wrap
  quvi_parse_close(&m);
}

Media::Media(const Media& v)
_init
{
  _swap(v);
}

#undef _init

Media& Media::operator=(const Media& v)
{
  if (this != &v) _swap(v);
  return *this;
}

Media::~Media()
{
}

void Media::_swap(const Media& m)
{
  page_title    = m.page_title;
  start_time    = m.start_time;
  page_url      = m.page_url;
  host          = m.host;
  id            = m.id;
  content_length = m.content_length;
  content_type  = m.content_type;
  file_suffix   = m.file_suffix;
  url           = m.url;
  thumbnail_url = m.thumbnail_url;
  duration      = m.duration;
}

// vim: set ts=2 sw=2 tw=72 expandtab:

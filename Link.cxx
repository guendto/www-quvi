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

Link::Link () :length_bytes (-1) { }

Link::Link (quvi_video_t qv) :length_bytes (-1)
{
#define _wrap(id,dst,type) \
    do { type t; quvi_getprop(qv,id,&t); dst=t; } while (0)
  _wrap(QUVIPROP_VIDEOURL,             url,           char*);
  _wrap(QUVIPROP_VIDEOFILECONTENTTYPE, content_type,  char*);
  _wrap(QUVIPROP_VIDEOFILESUFFIX,      file_suffix,   char*);
  _wrap(QUVIPROP_VIDEOFILELENGTH,      length_bytes, double);
#undef _wrap
}

Link::Link (const Link& l) :length_bytes (-1)
{
  _swap (l);
}

Link& Link::operator=(const Link& l)
{
  if (this != &l) _swap (l);
  return *this;
}

Link::~Link () { }

void
Link::_swap (const Link& l)
{
  content_type = l.content_type;
  file_suffix  = l.file_suffix;
  url          = l.url;
  length_bytes = l.length_bytes;
}

// vim: set ts=2 sw=2 tw=72 expandtab:

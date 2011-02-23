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

Video::Video () :ok (false) { }

Video::Video (quvi_video_t qv) :ok (true)
{
#define _wrap(id,dst,type) \
    do { type t; quvi_getprop(qv,id,&t); dst=t; } while (0)
  _wrap(QUVIPROP_HOSTID,      host,       char*);
  _wrap(QUVIPROP_PAGEURL,     url,        char*);
  _wrap(QUVIPROP_PAGETITLE,   title,      char*);
  _wrap(QUVIPROP_VIDEOID,     id,         char*);
  _wrap(QUVIPROP_STARTTIME,   start_time, char*);
#undef _wrap
  link = Link (qv);
  quvi_parse_close (&qv);
}

Video::Video (const Video& v) :ok (false)
{
  _swap (v);
}

Video&
Video::operator=(const Video& v)
{
  if (this != &v) _swap (v);
  return *this;
}

Video::~Video () { }

void
Video::_swap (const Video& v)
{
  title       = v.title;
  host        = v.host;
  url         = v.url;
  id          = v.id;
  link        = v.link;
  ok          = v.ok;
  start_time  = v.start_time;
}

// vim: set ts=2 sw=2 tw=72 expandtab:

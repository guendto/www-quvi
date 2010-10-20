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

Video::Video () :ok (false) { }

Video::Video (quvi_video_t qv) :ok (true) {
#define _wrap(id,dst,type) \
    do { type t; quvi_getprop(qv,id,&t); dst=t; } while (0)
    _wrap(QUVIPROP_HOSTID,      host,       char*);
    _wrap(QUVIPROP_PAGEURL,     url,        char*);
    _wrap(QUVIPROP_PAGETITLE,   title,      char*);
    _wrap(QUVIPROP_VIDEOID,     id,         char*);
#undef _wrap
    link = Link (qv);
    quvi_parse_close (&qv);
}

Video::Video (const Video& v) :ok (false) { _swap (v); }

Video&
Video::operator=(const Video& v) {
    if (this != &v) _swap (v);
    return *this;
}

Video::~Video () { }

void
Video::_swap (const Video& v) {
    title       = v.title;
    host        = v.host;
    url         = v.url;
    id          = v.id;
    link        = v.link;
    ok          = v.ok;
}



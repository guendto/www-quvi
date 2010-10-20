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

Link::Link () :length_bytes (-1) { }

Link::Link (quvi_video_t qv) :length_bytes (-1) { 
#define _wrap(id,dst,type) \
    do { type t; quvi_getprop(qv,id,&t); dst=t; } while (0)
    _wrap(QUVIPROP_VIDEOURL,             url,           char*);
    _wrap(QUVIPROP_VIDEOFILECONTENTTYPE, content_type,  char*);
    _wrap(QUVIPROP_VIDEOFILESUFFIX,      file_suffix,   char*);
    _wrap(QUVIPROP_VIDEOFILELENGTH,      length_bytes, double);
#undef _wrap
}

Link::Link (const Link& l) :length_bytes (-1) { _swap (l); }

Link& Link::operator=(const Link& l) {
    if (this != &l) _swap (l);
    return *this;
}

Link::~Link () { }

void
Link::_swap (const Link& l) {
    content_type = l.content_type;
    file_suffix  = l.file_suffix;
    url          = l.url;
    length_bytes = l.length_bytes;
}



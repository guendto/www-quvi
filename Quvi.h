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

#ifndef Quvi_h
#define Quvi_h

#include <quvi/quvi.h>

class Options;
class Query;
class Video;
class Link;

class Options {
public:
    Options ();
    Options (const Options&);
    Options& operator=(const Options&);
    virtual ~Options();
private:
    void _swap (const Options&);
public:
    std::string user_agent;
    std::string http_proxy;
    bool verbose_libcurl;
    std::string format;
    bool verify;
    bool shortened;
};

class Link {
public:
    Link ();
    Link (quvi_video_t);
    Link (const Link&);
    Link& operator=(const Link&);
    virtual ~Link();
private:
    void _swap (const Link&);
public:
    std::string content_type;
    std::string file_suffix;
    double length_bytes;
    std::string url;
};

class Video {
public:
    Video ();
    Video (quvi_video_t);
    Video (const Video&);
    Video& operator=(const Video&);
    virtual ~Video();
private:
    void _swap (const Video&);
public:
    std::string title;
    std::string host;
    std::string url;
    std::string id;
    Link link;
    bool ok;
};

class Query {
public:
    Query ();
    Query (const Query&);
    Query& operator=(const Query&);
    virtual ~Query();
public:
    Video parse (const std::string&, const Options&);
    int   next_website (std::string&, std::string&);
private:
    void _init ();
    void _close ();
private:
    quvi_t _quvi;
    void *_curl;
public:
    std::string last_error;
    long quvi_code;
    long resp_code;
};

#endif



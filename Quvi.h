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

#ifndef Quvi_h
#define Quvi_h

#include <quvi/quvi.h>

class Options;
class Query;
class Video;
class Link;

class Options
{
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
  long category;
};

class Link
{
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

class Video
{
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

class Query
{
public:
  Query ();
  Query (const Query&);
  Query& operator=(const Query&);
  virtual ~Query();
public:
  Video parse (const std::string&, const Options&);
  int   next_website (std::string&, std::string&);
  int   supported (const std::string&);
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

// vim: set ts=2 sw=2 tw=72 expandtab:

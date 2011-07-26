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
class Media;
class Url;

class Options
{
public:
  Options();
  Options(const Options&);
  Options& operator=(const Options&);
  virtual ~Options();
private:
  void _swap(const Options&);
public:
  std::string user_agent;
  std::string http_proxy;
  int verbose_libcurl;
  std::string format;
  long category;
  int resolve;
  int verify;
};

class Url
{
public:
  Url();
  Url(quvi_video_t);
  Url(const Url&);
  Url& operator=(const Url&);
  virtual ~Url();
private:
  void _swap(const Url&);
public:
  std::string content_type;
  std::string file_suffix;
  double length_bytes;
  std::string url;
};

class Media
{
public:
  Media();
  Media(quvi_video_t);
  Media(const Media&);
  Media& operator=(const Media&);
  virtual ~Media();
private:
  void _swap(const Media&);
public:
  std::string start_time;
  std::string page_url;
  std::string title;
  std::string host;
  std::string id;
  Url url;
  int ok;
};

class Query
{
public:
  Query();
  Query(const Query&);
  Query& operator=(const Query&);
  virtual ~Query();
public:
  Media parse(const std::string&, const Options&);
  int next_website(std::string&, std::string&);
  int supported(const std::string&);
private:
  void _init();
  void _close();
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

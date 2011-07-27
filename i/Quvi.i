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

%module  "WWW::Quvi"

%include "std_string.i"
%include "exception.i"
%include "typemaps.i"

%{
#include "Quvi.h"
%}

%inline %{

static char *_VERSION = VERSION;

typedef enum {
  libquviVersion      = QUVI_VERSION,
  libquviVersionLong  = QUVI_VERSION_LONG,
  ModuleVersion
} quviVersion;

static char* version(quviVersion n=ModuleVersion) {
  if (n == ModuleVersion) return _VERSION;
  return quvi_version(static_cast<QUVIversion>(n));
}

/*
 * A manual copy of QUVIcode. If there's a better way to do this,
 * I'd like to know it too. This will need to be maintained manually
 * if there are any changes to the QUVIcode enum list in quvi.h file.
 *
 * The reason we don't simply "%include <quvi/quvi.h>" and
 * get the constants is because that would clutter the wrapper.
 *
 * We have renamed the constants to avoid any conflicts with those
 * defined in <quvi/quvi.h> which is included by the wrapper.
 */
typedef enum {
  OK = 0x00,
  Mem,
  BadHandle,
  InvArg,
  CurlInit,
  Last,
  AbortedByCallback,
  LuaInit,
  NoLuaWebsite,
  NoLuaUtil,
  NoSupport =0x41,
  CallbackError,
  IconvError,      /* QUVI_ICONV */
  LuaError,        /* QUVI_LUA */
} quviCode;

typedef enum {
  ProtoHttp = 0x1,
  ProtoMms  = 0x2,
  ProtoRtsp = 0x4,
  ProtoRtmp = 0x8,
  ProtoAll  = (ProtoHttp|ProtoMms|ProtoRtsp|ProtoRtmp)
} quviCategory;

%} /* %inline */

class Options {
public:
  Options();
public:
  std::string user_agent;
  std::string http_proxy;
  int verbose_libcurl;
  std::string format;
  long category;
  int resolve;
  int verify;
};

class Url {
public:
  Url();
public:
%immutable;
  std::string content_type;
  std::string file_suffix;
  double length_bytes;
  std::string url;
};

class Media {
public:
  Media();
public:
%immutable;
  std::string start_time;
  std::string page_url;
  std::string title;
  std::string host;
  std::string id;
  Url url;
  int ok;
};

/* Query::_init throws std::runtime_error if quvi_init fails. */
%exception {
  try
    { $action }
  catch (const std::runtime_error& e)
    { SWIG_exception(SWIG_RuntimeError, e.what()); }
}

%apply std::string &OUTPUT { std::string &domain, std::string &formats };
%apply std::string &OUTPUT { std::string &formats };

class Query {
public:
  Query();
  virtual ~Query();
public:
  int next_website(std::string &domain, std::string &formats);
  int formats(const std::string& url, std::string &formats);
  int supported(const std::string&);
  Media parse(const std::string&);
  void set_opts(const Options&);
public:
%immutable;
  std::string last_error;
  long quvi_code;
  long resp_code;
};

%exception;

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

#include <stdexcept>
#include <cassert>
#include <string>

#include <curl/curl.h>

#include "Quvi.h"

#define _init_m \
 : _quvi(NULL), \
   _curl(NULL), \
   quvi_code(QUVI_OK), \
   resp_code(-1), \
   ok(1)

Query::Query()
_init_m
{
  _init();
}

Query::Query(const Query& q)
_init_m
{
  _init();
}

#undef _init_m

Query& Query::operator=(const Query& q)
{
  if (this != &q)
    {
      _close ();
      _init ();
    }
  return *this;
}

Query::~Query()
{
  _close();
}

void Query::_init()
{
  quvi_code = quvi_init(&_quvi);

  if (quvi_code != QUVI_OK)
    {
      const char *e = quvi_strerror(_quvi, static_cast<QUVIcode>(quvi_code));
      throw std::runtime_error(e);
    }

  quvi_getinfo(_quvi, QUVIINFO_CURL, &_curl);
  assert(_curl != NULL);

  set_opts(_opts);
}

void Query::_close()
{
  if (_quvi)
    quvi_close(&_quvi);
  assert(_quvi == NULL);
  _curl = NULL;
}

void Query::set_opts(const Options& opts)
{
  if ( !opts.format.empty() )
    quvi_setopt(_quvi, QUVIOPT_FORMAT, opts.format.c_str() );

  quvi_setopt(_quvi, QUVIOPT_NOVERIFY,  !opts.verify ? 1L:0L);
  quvi_setopt(_quvi, QUVIOPT_NORESOLVE, !opts.resolve ? 1L:0L);

  quvi_setopt(_quvi, QUVIOPT_CATEGORY, opts.category);

  if ( !opts.user_agent.empty() )
    curl_easy_setopt(_curl, CURLOPT_USERAGENT, opts.user_agent.c_str());

  if ( !opts.http_proxy.empty() )
    curl_easy_setopt(_curl, CURLOPT_PROXY, opts.http_proxy.c_str());

  curl_easy_setopt(_curl, CURLOPT_VERBOSE, opts.verbose_libcurl ? 1L:0L);
}

Media Query::parse(const std::string& url)
{
  quvi_media_t m;
  quvi_code = quvi_parse(_quvi, const_cast<char*>(url.c_str()), &m);

  quvi_getinfo(_quvi, QUVIINFO_RESPONSECODE, &resp_code);

  Media res;

  if (quvi_code != QUVI_OK)
    _format_error();
  else
    {
      res = Media(m);
      ok = 1;
    }

  return res;
}

void Query::next_website(std::string& domain,
                         std::string& formats)
{
  char *d=NULL, *f=NULL;
  quvi_code = quvi_next_supported_website(_quvi, &d, &f);

  if (quvi_code == QUVI_OK)
    {
      domain = d;
      quvi_free(d);
      formats = f;
      quvi_free(f);
      ok = 1;
    }
  else
    ok = 0;
}

void Query::_format_error()
{
  const char *e = quvi_strerror(_quvi, static_cast<QUVIcode>(quvi_code));
  errmsg = std::string(e);
  ok = 0;
}

int Query::supported(const std::string& url)
{
  quvi_code = quvi_supported(_quvi, const_cast<char*>(url.c_str()));

  if (quvi_code != QUVI_OK)
    _format_error();

  return static_cast<int>(quvi_code);
}

std::string Query::formats(const std::string& url)
{
  char *s = NULL;

  quvi_code =
    quvi_query_formats(_quvi, const_cast<char*>(url.c_str()), &s);

  quvi_getinfo(_quvi, QUVIINFO_RESPONSECODE, &resp_code);

  std::string res;

  if (quvi_code != QUVI_OK)
    _format_error();
  else
    {
      res = s;
      quvi_free(s);
      ok = 1;
    }

  return res;
}

// vim: set ts=2 sw=2 tw=72 expandtab:

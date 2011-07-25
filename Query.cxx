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
#include <stdexcept>
#include <cassert>

#include <curl/curl.h>

#include "Quvi.h"

Query::Query()
  : _quvi(NULL),
    _curl(NULL),
    quvi_code(QUVI_OK),
    resp_code(-1)
{
  _init();
}

Query::Query(const Query& q)
  : _quvi(NULL),
    _curl(NULL),
    quvi_code(QUVI_OK),
    resp_code(-1)
{
  _init();
}

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
}

void Query::_close()
{
  if (_quvi)
    quvi_close(&_quvi);
  assert(_quvi == NULL);
  _curl = NULL;
}

Media Query::parse(const std::string& url, const Options& opts)
{
  if ( !opts.format.empty() )
    quvi_setopt(_quvi, QUVIOPT_FORMAT, opts.format.c_str() );

  quvi_setopt(_quvi, QUVIOPT_NOVERIFY,  !opts.verify ? 1L:0L);
  quvi_setopt(_quvi, QUVIOPT_NORESOLVE, !opts.resolve ? 1L:0L);

  quvi_setopt(_quvi, QUVIOPT_CATEGORY, opts.category);

  if ( !opts.user_agent.empty() )
    curl_easy_setopt(_curl, CURLOPT_USERAGENT, opts.user_agent.c_str());

  if ( !opts.http_proxy.empty() )
    curl_easy_setopt(_curl, CURLOPT_PROXY, opts.http_proxy.c_str() );

  curl_easy_setopt(_curl, CURLOPT_VERBOSE, opts.verbose_libcurl ? 1L:0L);

  quvi_media_t m;
  quvi_code = quvi_parse(_quvi, const_cast<char*>(url.c_str()), &m);

  quvi_getinfo(_quvi, QUVIINFO_HTTPCODE, &resp_code);

  if (quvi_code != QUVI_OK)
    {
      const char *e = quvi_strerror(_quvi, static_cast<QUVIcode>(quvi_code));
      last_error = std::string(e);
      return Media();
    }

  return Media(m);
}

int Query::next_website(std::string& domain, std::string& formats)
{
  char *d=NULL, *f=NULL;
  const QUVIcode rc = quvi_next_supported_website(_quvi, &d, &f);
  if (rc == QUVI_OK)
    {
      domain  = d;
      formats = f;
      quvi_free(d);
      quvi_free(f);
    }
  return static_cast<int>(rc);
}

int Query::supported(const std::string& url)
{
  quvi_code = quvi_supported(_quvi, const_cast<char*>(url.c_str()));

  if (quvi_code != QUVI_OK)
    {
      const char *e =
        quvi_strerror(_quvi, static_cast<QUVIcode>(quvi_code));

      last_error = std::string(e);
    }

  return static_cast<int>(quvi_code);
}

// vim: set ts=2 sw=2 tw=72 expandtab:


%module  "WWW::Quvi"

%include "std_string.i"
%include "exception.i"
%include "typemaps.i"

%{
#include "Quvi.h"
%}

%inline %{

char *_VERSION = VERSION;

typedef enum {
    libquviVersion      = QUVI_VERSION,
    libquviVersionLong  = QUVI_VERSION_LONG,
    ModuleVersion
} quviVersion;

static char* version (quviVersion n=ModuleVersion) {
    if (n == ModuleVersion) return _VERSION;
    return quvi_version ((QUVIversion)n);
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
OK  = 0x00,
Mem,
BadHandle,
InvArg,
CurlInit,
Last,
AbortedByCallback,
LuaInit,
NoLuaWebsite,
NoLuaUtil,
PcreError= 0x40, /* QUVI_PCRE */
NoSupport,
CurlError,       /* QUVI_CURL */
IconvError,      /* QUVI_ICONV */
LuaError,        /* QUVI_LUA */
} quviCode;

%}

class Options {
public:
    Options ();
public:
    std::string user_agent;
    std::string http_proxy;
    bool verbose_libcurl;
    std::string format;
    bool verify;
};

class Link {
public:
    Link ();
public:
%immutable;
    std::string content_type;
    std::string file_suffix;
    double length_bytes;
    std::string url;
};

class Video {
public:
    Video ();
public:
%immutable;
    std::string title;
    std::string host;
    std::string url;
    std::string id;
    Link link;
    bool ok;
};

/* Query::_init throws std::runtime_error if quvi_init fails. */
%exception {
    try
        { $action }
    catch (const std::runtime_error& e)
        { SWIG_exception (SWIG_RuntimeError, e.what ()); }
}

%apply std::string &OUTPUT { std::string &domain, std::string &formats };

class Query {
public:
    Query ();
    virtual ~Query ();
public:
    Video parse (const std::string&, const Options&);
    int   next_website (std::string &domain, std::string &formats);
public:
%immutable;
    std::string last_error;
    long quvi_code;
    long resp_code;
};

%exception;



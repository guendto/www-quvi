#!/bin/sh

swigity_flag=off
build_flag=off
clean_flag=off

while [ $# -gt 0 ]
do
    case "$1" in
        -s) swigity_flag=on;;
        -b) build_flag=on;;
        -c) clean_flag=on;;
    esac
    shift
done

swigity()
{
    swig -c++ -const -outdir lib/WWW -perl5  \
        -I/usr/include $quvi_CFLAGS Quvi.i
    exit $?
}

build_so()
{
    quvi_CFLAGS=`pkg-config --cflags libquvi`
    quvi_LDFLAGS=`pkg-config --libs libquvi`

    perl_CFLAGS=`perl -MExtUtils::Embed -e ccopts`
    perl_LDFLAGS=`perl -MExtUtils::Embed -e ldopts`

    g++ -g Quvi_wrap.cxx \
        -I . \
        Options.cxx \
        Link.cxx \
        Video.cxx \
        Query.cxx \
        -fpic -shared -o Quvi.so \
        $quvi_CFLAGS $quvi_LDFLAGS \
        $perl_CFLAGS $perl_LDFLAGS 

    exit $?
}

clean()
{
    rm Quvi.so
    exit $?
}

if [ x"$swigity_flag" = "xon" ]; then
    swigity
fi

if [ x"$build_flag" = "xon" ]; then
    build_so
fi

if [ x"$clean_flag" = "xon" ]; then
    clean
fi

echo "
usage: $0 [-s | -b | -c]

-s .. run swig against Quvi.i
-b .. build, compile a shared library from swig wrapper code
-c .. cleanup, remove the shared library created with -b

Most users will want to use the Makefile.PL instead.
This script was written to aid the development work."
exit 0



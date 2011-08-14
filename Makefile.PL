
use warnings;
use strict;

use 5.010001;
use ExtUtils::MakeMaker;
use ExtUtils::PkgConfig;
use ExtUtils::Depends;

my $CXXFLAGS = '-Wall -Ii';
my $CXX      = 'g++';
my $LD       = 'g++';

my @OBJS;
push @OBJS, $_.'$(OBJ_EXT)'
    foreach qw(Media Options Query Quvi_wrap);

my %pkgcfg_libquvi = ExtUtils::PkgConfig->find('libquvi >= 0.2.17');

my $libquvi = ExtUtils::Depends->new('libquvi');
$libquvi->set_inc($pkgcfg_libquvi{cflags});
$libquvi->set_libs($pkgcfg_libquvi{libs});

WriteMakefile(
  NAME            => 'WWW::Quvi',
  DISTNAME        => 'WWW-Quvi',
  VERSION         => '0.2.0',
  CC              => $CXX,
  CCFLAGS         => $CXXFLAGS,
  LD              => $LD,
  OBJECT          => (join ' ',@OBJS),
  PREREQ_PM => {
  },
  BUILD_REQUIRES => {
    'ExtUtils::MakeMaker' => 0,
    'ExtUtils::PkgConfig' => 0,
    'ExtUtils::Depends' => 0,
  },
  CONFIGURE_REQUIRES => {
    'ExtUtils::MakeMaker' => 0,
    'ExtUtils::PkgConfig' => 0,
    'ExtUtils::Depends' => 0,
  },
  MIN_PERL_VERSION => 5.010001,
  ($] >= 5.005 ?
    (ABSTRACT_FROM => 'lib/WWW/Quvi.pod',
     AUTHOR => 'Toni Gundogdu <legatvs@cpan.org>') : ()),
  LICENSE        => 'LGPLv2.1+',
  dist => {
    PREOP =>
'@if test -f .git/HEAD; then \
	git log --stat --after="Mon Feb 21 20:39:18 2011" >ChangeLog; \
fi',
    POSTOP =>
'@if test -f .git/HEAD; then \
	git checkout ChangeLog; \
fi',
    },
    $libquvi->get_makefile_vars,
);

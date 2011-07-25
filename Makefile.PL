
use warnings;
use strict;

use 5.008009;
use ExtUtils::MakeMaker;
use ExtUtils::PkgConfig;
use ExtUtils::Depends;

my $CXXFLAGS = '-Wall';
my $CXX      = 'g++';
my $LD       = 'g++';

my @OBJS;
push @OBJS, $_.'$(OBJ_EXT)'
    foreach qw(Media Options Query Quvi_wrap Url);

my %pkgcfg_libquvi = ExtUtils::PkgConfig->find('libquvi >= 0.2.17');

my $libquvi = ExtUtils::Depends->new('libquvi');
$libquvi->set_inc($pkgcfg_libquvi{cflags});
$libquvi->set_libs($pkgcfg_libquvi{libs});

WriteMakefile(
    NAME            => 'WWW::Quvi',
    VERSION         => '0.05',
    CC              => $CXX,
    CCFLAGS         => $CXXFLAGS,
    LD              => $LD,
    OBJECT          => (join ' ',@OBJS),
    ( $[ >= 5.8 )
    ? ( AUTHOR     => 'Toni Gundogdu legatvs at sign gmail com',
        'ABSTRACT' => 'Perl bindings for libquvi'
        )
    : (),
    'PREREQ_PM' => {
# Earlier versions may work. The module has been confirmed to work with:
# Optional:
'Test::Pod' => 1.44, # <http://search.cpan.org/perldoc?Test::Pod>
    },
    LICENSE        => 'lgpl',
    dist => {
        PREOP =>
'@if test -f .git/HEAD; then \
	git log --stat --after="Mon Feb 21 20:39:18 2011" >ChangeLog; \
fi',
        POSTOP   =>
'@if test -f .git/HEAD; then \
	git checkout ChangeLog; \
fi',
    },
    $libquvi->get_makefile_vars,
);

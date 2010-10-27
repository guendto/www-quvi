
use warnings;
use strict;

use 5.008009;
use ExtUtils::MakeMaker;
use ExtUtils::PkgConfig;
use ExtUtils::Depends;

my $CXXFLAGS = '-Wall';
my $CXX      = 'g++';
my $LD       = 'g++';

my %pkgcfg_libquvi = ExtUtils::PkgConfig->find ('libquvi >= 0.2.5');

my $libquvi = ExtUtils::Depends->new ('libquvi');
$libquvi->set_inc  ($pkgcfg_libquvi{cflags});
$libquvi->set_libs ($pkgcfg_libquvi{libs});

WriteMakefile(
    NAME            => 'WWW::Quvi',
    VERSION         => '0.03',
    CC              => $CXX,
    CCFLAGS         => $CXXFLAGS,
    LD              => $LD,
    OBJECT          =>
        'Quvi_wrap.o Options.o Link.o Video.o Query.o',
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
    LICENSE        => 'gpl',
    $libquvi->get_makefile_vars,
);

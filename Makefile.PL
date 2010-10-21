
use warnings;
use strict;

use 5.008009;
use ExtUtils::MakeMaker;

my $CXX      = 'g++';
my $LD       = 'g++';
my $CXXFLAGS = '-Wall';

WriteMakefile(
    NAME            => 'WWW::Quvi',
    VERSION         => '0.02',
    CC              => $CXX,
    CCFLAGS         => $CXXFLAGS,
    LD              => $LD,
    LIBS            => ['-L/usr/lib', '-lquvi'],
    INC             => '-I/usr/include',
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
    LICENSE        => 'GPLv3+',
);

#!/usr/bin/env perl
#
# WWW::Quvi
# Copyright (C) 2011  Toni Gundogdu <legatvs@gmail.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
#

# get_media.pl - Simple media downloader
# Note the use of custom user-agent string.

use warnings;
use strict;

use LWP::UserAgent;
use Carp qw(croak);
use WWW::Quvi;

use constant AGENT => 'Mozilla/5.0';
use constant URL   => 'http://vimeo.com/26721145';

# Quvi options.

my $o = new WWW::Quvi::Options;
$o->{user_agent} = AGENT;

# Query media.

print STDERR "Querying media...\n";

my $q = new WWW::Quvi::Query;
$q->set_opts($o);

my $m = $q->parse(URL);
croak "error: $q->{errmsg}\n" unless $q->{ok};

# Save to file.

my $fn = "$m->{page_title}.$m->{file_suffix}";
print STDERR "Saving to $fn...\n";

my $ua = new LWP::UserAgent;
$ua->env_proxy;
$ua->agent(AGENT);

open my $fh, ">", "$fn" or croak "$?";
my $bytes_received = 0;

my $res =
  $ua->request(HTTP::Request->new(GET => $m->{url}),
  sub {
    my ($chunk,$res) = @_;
    $bytes_received += length($chunk);
    printf STDERR "%d%% - ",
      100*$bytes_received/$m->{content_length};
    print STDERR "$bytes_received bytes received\r";
    print $fh $chunk;
  });

close $fh;
print "\n", $res->status_line, "\n";

# vim: set ts=2 sw=2 tw=72 expandtab:

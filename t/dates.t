#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 4;

use Module::Release;

BEGIN {
    use File::Spec;
    my $file = File::Spec->catfile(qw(. t lib setup_common.pl));
    require $file;
}

my $release = Module::Release->new;

like(
    $release->get_release_date,
    qr/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$/,
    "Returns datetime in UTC as a string in required format"
);

{
    no warnings 'redefine';
    local *DateTime::datetime = sub { '2017-09-02T10:05:49' };
    is( $release->get_release_date,
        '2017-09-02T10:05:49Z',
        "Returns known datetime as a string in required format" );
}

# vim: expandtab shiftwidth=4

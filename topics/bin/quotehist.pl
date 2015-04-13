#!/usr/bin/env perl

use Finance::QuoteHist;
use POSIX qw(strftime localtime time);

$q = Finance::QuoteHist->new
    (
     symbols    => [split(",", @ARGV[0])],
     start_date => @ARGV[1] || '1 year ago', # or '1 year ago', see Date::Manip
     end_date   => @ARGV[2] || 'today',
    );

# Quotes
foreach $row ($q->quotes()) {
    ($symbol, $date, $open, $high, $low, $close, $volume) = @$row;
    print "P ";
    print $date, " 16:00:00";
    print " ", $symbol, " ";
    print "\$", $close, "\n";
}


#!/usr/bin/perl

use warnings;
use strict;
use lib "$ENV{HOME}/perl5/lib/perl5";
use Data::Dumper;
use Net::DNS;
use Net::Telnet;

while(<>) {
	print "$_";
	my($username, $domain) = split("@", $_);
	my $mx = mx_nslookup('gmail.com');
	my $mxns;
	if(keys $mx) {
		foreach (sort {$a<=>$b} keys $mx) {
			$mxns = $mx->{$_};
			last;
		}
	}
}

sub mx_nslookup {
	my $mxs = {};
	my $domain = shift;
	my $res = Net::DNS::Resolver->new;
	my @mx = mx($res, $domain);

	if(@mx) {
		foreach my $rr (@mx) {
			$mxs->{$rr->preference} = $rr->exchange;
		}
	}

	return $mxs;
}

sub telnet {
	my $host = shift;
	my $telnetobj = new Net::Telnet(Host => $host, Port => 25);
}

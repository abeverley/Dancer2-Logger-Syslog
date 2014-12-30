use strict;
use warnings;
use Test::More;

plan tests => 8;

use Dancer2::Logger::Syslog;

my $l = Dancer2::Logger::Syslog->new( app_name => 'test', log_level => 'core' );

ok defined($l), 'Dancer2::Logger::Syslog object';
isa_ok $l, 'Dancer2::Logger::Syslog';
can_ok $l, qw(log debug warning error);

SKIP: { 
    eval { $l->log(debug => "dummy test") };
    skip "Need a SysLog connection to run last tests", 5 
        if $@ =~ /no connection to syslog available/;

    ok($l->log(debug => "Perl Dancer test message 1/4"), "log works");
    ok($l->log(core => "Perl Dancer test message (core) 1/4"), 
        "log works with 'core' level");
    ok($l->debug("Perl Dancer test message 2/4"), "debug works");
    ok($l->warning("Perl Dancer test message 3/4"), "warning works");
    ok($l->error("Perl Dancer test message 4/4"), "error works");
};

use strict;
#use Test::More tests => 1;
use Test::More qw(no_plan);;
use Module::Recursive::Require;

INIT {
    use lib 't/testlib';
}

my $r = Module::Recursive::Require->new();

isa_ok($r, 'Module::Recursive::Require');
can_ok($r, qw/add_filter require_by/);

ok( $r->add_filter(qr/^Base\.pm$/), 'add filter test' );

my $modules = $r->require_by('MyApp');
eq_set( $modules, [qw/MyApp::Foo MyApp::Test MyApp::Mail MyApp::Mail::LoveMail/]);

my $love_mail = MyApp::Mail::LoveMail->new();
isa_ok($love_mail, 'MyApp::Mail::LoveMail');

ok( $love_mail->send(), 'MyApp::Mail::LoveMail->send Test!');

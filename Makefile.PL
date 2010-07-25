use inc::Module::Install;
name 'NoPaste';
all_from 'lib/NoPaste.pm';

requires 'Text::Xslate' => 0.1047;
requires 'Text::Xslate::Bridge::TT2Like';
requires 'Mouse';
requires 'Log::Dispatch';
requires 'parent';
requires 'DBIx::Skinny';

tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More';
test_requires 'YAML';
test_requires 'Test::WWW::Mechanize::PSGI';
test_requires 'Test::Requires';
author_tests('xt');
auto_include;
WriteAll;


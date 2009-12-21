use inc::Module::Install;
all_from "lib/OreOre/NoPaste.pm";
use 5.0100;

tests 't/*.t t/*/*.t t/*/*/*.t';
requires 'Data::UUID';
requires 'Amon';

WriteAll;

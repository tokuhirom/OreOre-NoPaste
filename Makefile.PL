use inc::Module::Install;
all_from "lib/OreOre/NoPaste.pm";

tests 't/*.t t/*/*.t t/*/*/*.t';
requires 'Amon';

WriteAll;

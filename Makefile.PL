use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Config::Properties::Simple',
    'VERSION_FROM'	=> 'Simple.pm', # finds $VERSION
    'PREREQ_PM'		=> {'Config::Properties' => 0,
			    'Config::Find' => 0 },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'Simple.pm', # retrieve abstract from module
       AUTHOR     => 'Salva <salva@nonet>') : ()),
);

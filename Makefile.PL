use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile( 'NAME'	       => 'Config::Properties::Simple',
	       'VERSION_FROM'  => 'Simple.pm', # finds $VERSION
	       'PREREQ_PM'     => {'Config::Properties' => 0.43,
				   'Config::Find' => 0.06 },
	       'ABSTRACT_FROM' => 'Simple.pm', # retrieve abstract from module
	       'AUTHOR'        => 'Salvador Fandiño <sfandino@yahoo.com>' );

package Config::Properties::Simple;

use 5.006;

our $VERSION = '0.05';

use strict;
use warnings;
use Carp;

use Config::Properties;
use Config::Find;

our @ISA=qw(Config::Properties Config::Find);

sub new {
  my ($class, %opts)=@_;

  my $defaults;
  if (defined $opts{defaults}) {
    $defaults=Config::Properties->new();
    for my $k (keys %{$opts{defaults}}) {
      $defaults->setProperty($k, $opts{defaults}->{$k})
    }
  }

  my $this=$class->SUPER::new($defaults);

  $this->{simple_opts}=\%opts;


  exists $opts{format}
    and $this->setFormat($opts{format});

  unless ($opts{noread}) {
    my $fh=$this->open(%opts);
    unless ($fh) {
      return $this if ($opts{optional} and !defined $opts{file})
      or croak 'unable to open configuration file for reading';
    }
    $this->load($fh);
    close $fh
      or croak 'unable to read configuration file';
  }

  return $this;
}

sub save {
  my $this=shift;
  my %opts= (%{$this->{simple_opts}}, mode => 'w', @_);
  my $fh=$this->open(%opts)
    or croak 'unable to open configuration file for writing';
  my $header=$opts{header}
    || 'Automatically generated configuration file';
  $this->SUPER::save($fh, $header);
  close $fh
    or croak 'unable to write configuration file';
}

1;
__END__

=head1 NAME

Config::Properties::Simple - Perl extension to manage properties files.

=head1 SYNOPSIS

  use Config::Properties::Simple;

  my $cfg=Config::Properties::Simple->new();
  my $foo=$cfg->getProperty('foo', 'default foo');

  $cfg->setProperty(bar => 'my bar')
  $cfg->save

=head1 ABSTRACT

Wrapper around L<Config::Properties> to simplify its use.

=head1 DESCRIPTION

This package mix functionality in L<Config::Properties> and
L<Config::Find> packages to provide a simple access to
configuration files.

It changes C<new> and C<save> methods of L<Config::Properties> (every
other method continues to work as usual):

=over 4

=item Config::Properties::Simple-E<gt>new(%opts)

creates a new L<Config::Properties::Simple> object and reads on the
configuration file determined by the options passed through C<%opts>.

The supported ptions are:

=over 4

=item C<defaults =E<gt> {...}>

hash reference containing default values for the configuration keys
(similar to C<defaultProperties> field in the original
C<Config::Properties::new> constructor).

=item C<noread =E<gt> 1>

stops properties for being read from a file.

=item C<optional =E<gt> 1>

by default an exception is thrown when the configuration file can not
be find or opened, this option makes the constructor succeed anyway.

If the C<file> option is included and defined the constructor dies
even with C<optional> set.

=item C<format =E<gt> $format>

equivalent to calling C<setFormat> method.

=back

In addition, any option accepted by L<Config::Find> is also allowed
here.

=item $this-E<gt>save(%opts)

creates a new configuration file with the properties defined in the
object.

C<%opts> are passed to Config::Find to determine the configuration
file name and location.

=back

=head2 EXPORT

None, this package is OO.


=head1 SEE ALSO

L<Config::Properties>, L<Config::Find>.

=head1 AUTHOR

Salvador Fandiño, E<lt>sfandino@yahoo.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Salvador Fandiño

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

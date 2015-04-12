package Function::Fallback::CoreOrPP::ScalarUtilNumeric;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(
                       isint
                       isnum
                       isnan
                       isinf
                       isneg
                       isfloat
               );

sub isint {
    local $_ = shift;
    return 0 unless defined;
    return 1 if /\A[+-]?(?:0|[1-9][0-9]*)\z/;
    0;
}

sub isnan($) {
    local $_ = shift;
    return 0 unless defined;
    return 1 if /\A\s*[+-]?nan\s*\z/i;
    0;
}

sub isinf($) {
    local $_ = shift;
    return 0 unless defined;
    return 1 if /\A\s*[+-]?inf(?:inity)?\s*\z/i;
    0;
}

sub isneg($) {
    local $_ = shift;
    return 0 unless defined;
    return 1 if /\A\s*-/;
    0;
}

sub isnum($) {
    goto &isfloat;
}

sub isfloat($) {
    local $_ = shift;
    return 0 unless defined;
    return 1 if /\A[+-]?(?:0|[1-9][0-9]*)(?:\.[0-9]+)?(?:[eE][+-]?[0-9]+)?\z/;
    return 1 if isnan($_) || isinf($_);
    0;
}

1;
#ABSTRACT: Pure-perl drop-in replacement/approximation of Scalar::Util::Numeric

=head1 SYNOPSIS


=head1 DESCRIPTION

This module is written mainly for the convenience of L<Data::Sah>, as a drop-in
pure-perl replacement for the XS module L<Scalar::Util::Numeric>, in the case
when Data::Sah needs to generate code that uses PP modules instead of XS ones.


=head1 SEE ALSO

L<Data::Sah>

L<Scalar::Util::Numeric>

=cut

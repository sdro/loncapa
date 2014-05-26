# The LearningOnline Network with CAPA - LON-CAPA
# QVector
#
# Copyright (C) 2014 Michigan State University Board of Trustees
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

##
# A vector of quantities
##
package QVector;

use strict;
use warnings;

use Quantity;

##
# Constructor
# @param {Quantity[]} quantities
##
sub new {
    my $class = shift;
    my $self = {
        _quantities => shift,
    };
    bless $self, $class;
    return $self;
}

# Attribute helpers
sub quantities {
    my $self = shift;
    return $self->{_quantities};
}

##
# Returns a readable view of the object
# @returns {string}
##
sub toString {
    my ( $self ) = @_;
    my $s = "[";
    for (my $i=0; $i < scalar(@{$self->quantities}); $i++) {
        $s .= $self->quantities->[$i]->toString();
        if ($i != scalar(@{$self->quantities}) - 1) {
            $s .= "; ";
        }
    }
    $s .= "]";
    return $s;
}

##
# Addition
# @param {QVector}
# @returns {QVector}
##
sub add {
    my ( $self, $v ) = @_;
    my @t = (); # array of Quantity
    for (my $i=0; $i < scalar(@{$self->quantities}); $i++) {
        $t[$i] = $self->quantities->[$i]->add($v->quantities->[$i]);
    }
    return new QVector(\@t);
}

##
# Substraction
# @param {QVector}
# @returns {QVector}
##
sub sub {
    my ( $self, $v ) = @_;
    my @t = (); # array of Quantity
    for (my $i=0; $i < scalar(@{$self->quantities}); $i++) {
        $t[$i] = $self->quantities->[$i]->sub($v->quantities->[$i]);
    }
    return new QVector(\@t);
}

##
# Negation
# @returns {QVector}
##
sub neg {
    my ( $self ) = @_;
    my @t = (); # array of Quantity
    for (my $i=0; $i < scalar(@{$self->quantities}); $i++) {
        $t[$i] = $self->quantities->[$i]->neg();
    }
    return new QVector(\@t);
}

##
# Multiplication by a scalar
# @returns {QVector}
##
sub mult {
    my ( $self, $q ) = @_;
    my @t = (); # array of Quantity
    for (my $i=0; $i < scalar(@{$self->quantities}); $i++) {
        $t[$i] = $self->quantities->[$i]->mult($q);
    }
    return new QVector(\@t);
}

##
# Dot product
# @returns {QVector}
##
sub dot {
    my ( $self, $v ) = @_;
    my @t = (); # array of Quantity
    for (my $i=0; $i < scalar(@{$self->quantities}); $i++) {
        $t[$i] = $self->quantities->[$i]->mult($v->quantities->[$i]);
    }
    return new QVector(\@t);
}

1;
__END__

# The LearningOnline Network with CAPA - LON-CAPA
# Deal with everything having to do with users
# 
# Copyright (C) 2014 Michigan State University Board of Trustees
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
package Apache::lc_entity_users;

use strict;
use DBI;
use Apache::lc_logs;

# ================================================================
# Convert stuff to entities
# ================================================================
# ==== Usernames to entities
#
sub username_to_entity {
    my ($username,$domain)=@_;
}

# ==== PIDs to entities
#
sub pid_to_entity {
    my ($pid,$domain)=@_;
}


1;
__END__

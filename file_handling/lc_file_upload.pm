# The LearningOnline Network with CAPA - LON-CAPA
# Uploading files from client - server-side 
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

package Apache::lc_file_upload;

use strict;

use Apache2::Const qw(:common);
use Apache::lc_logs;
use Apache::lc_parameters;
use Apache::lc_file_utils();

use Data::Dumper;

sub handler {
   &logdebug(&Apache::lc_file_utils::move_uploaded_into_place('/home/www/Desktop/test.txt'));
   return OK;
}

1;
__END__

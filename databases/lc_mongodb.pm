# The LearningOnline Network with CAPA - LON-CAPA
# Deal with MongoDB
#
# !!!
# !!! These are low-level routines. They do no sanity checking on parameters!
# !!! Do not call from higher level handlers, do no not use direct user input
# !!!
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
package Apache::lc_mongodb;

use strict;
use MongoDB;
use Apache::lc_logs;

use vars qw($client $database);

#
# Initialize the MongoDB client, local host
#
sub init_mongo {
# Open the client. If fail, will likely take down Apache child,
# but that's okay - we need the database to run
   if ($client=MongoDB::MongoClient->new()) {
      &lognotice("Connected to MongoDB");
   } else {
      &logerror("Could not connect to MongoDB");
   }
# Get the LON-CAPA database in MongoDB
   $database=$client->get_database('loncapa');
}

BEGIN {
   &init_mongo();
}

1;
__END__

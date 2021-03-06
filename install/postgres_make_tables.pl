# The LearningOnline Network with CAPA - LON-CAPA
# Initialize the tables in PostgreSQL
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
use strict;
use DBI;

my $dbh;

#
# Make the URLS table
#
sub make_urls_table {
   my $urltable=(<<ENDURLTABLE);
create table urls
(url text primary key not null,
entity text not null)
ENDURLTABLE
   my $rv=$dbh->do($urltable);
}

#
# Make the user lookup table
# Get the entity for a username
#
sub make_user_lookup_table {
   my $userstable=(<<ENDUSERSTABLE);
create table userlookup
(username text not null,
domain text not null,
entity text not null,
primary key (username,domain))
ENDUSERSTABLE
   my $rv=$dbh->do($userstable);
}

#
# Make the pid lookup table
# Get the entity for a PID
#
sub make_pid_lookup_table {
   my $pidstable=(<<ENDPIDSTABLE);
create table pidlookup
(pid text not null,
domain text not null,
entity text not null,
primary key (pid,domain))
ENDPIDSTABLE
   my $rv=$dbh->do($pidstable);
}

#
# Make the courseID lookup table
# Get the entity for a courseID
#
sub make_courseid_lookup_table {
   my $coursestable=(<<ENDCOURSESTABLE);
create table courselookup
(courseid text not null,
domain text not null,
entity text not null,
primary key (courseid,domain))
ENDCOURSESTABLE
   my $rv=$dbh->do($coursestable);
}

#
# Make the homeserver lookup table
#
sub make_homeserver_lookup_table {
   my $homeservertable=(<<ENDHOMESERVERTABLE);
create table homeserverlookup
(entity text not null,
domain text not null,
homeserver text not null,
primary key (entity,domain))
ENDHOMESERVERTABLE
   my $rv=$dbh->do($homeservertable);
}

#
# The role table
# These are the roles on this server
# The primary cluster server (and only the primary cluster server)
# also has the system and domain-wide roles
# This is for lookup, the actual roles are with the users
#
sub make_role_lookup_table {
   my $rolelisttable=(<<ENDROLELIST);
create table rolelist
(roleentity text,
roledomain text,
rolesection text,
userentity text not null,
userdomain text not null,
role text not null,
startdate timestamp,
enddate timestamp,
manualenrollentity text,
manualenrolldomain text,
primary key (roleentity,roledomain,rolesection,userentity,userdomain,role))
ENDROLELIST
   my $rv=$dbh->do($rolelisttable);
}

#
# This is the big table of course assessments on the homeserver of the courses
# Authoritative
#
sub make_assessment_table {
   my $assessmenttable=(<<ENDASSESSMENTTABLE);
create table assessments
(courseentity text not null,
coursedomain text not null,
userentity text not null,
userdomain text not null,
resourceid text not null,
partid text not null,
scoretype text,
score text,
totaltries text,
countedtries text,
status text,
responsedetailsjson text,
primary key (courseentity,coursedomain,userentity,userdomain,resourceid,partid))
ENDASSESSMENTTABLE
   my $rv=$dbh->do($assessmenttable);
}



#
# Initialize the postgreSQL handle, local host
#
sub init_postgres {
   if ($dbh=DBI->connect('DBI:Pg:dbname=loncapa;host=127.0.0.1;port=5432','loncapa','loncapa',{ RaiseError => 0 })) {
      print "Connected to PostgreSQL\n";
   } else {
      print "Could not connect to PostgreSQL, ".$DBI::errstr."\n";
   } 
}

# Make all the tables
#
   &init_postgres();
   &make_urls_table();
   &make_user_lookup_table();
   &make_pid_lookup_table();
   &make_courseid_lookup_table();
   &make_homeserver_lookup_table();
   &make_role_lookup_table();
   &make_assessment_table();

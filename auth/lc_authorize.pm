# The LearningOnline Network with CAPA - LON-CAPA
# Deal with authorization
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
package Apache::lc_authorize;

use strict;
use Apache::lc_file_utils();
use Apache::lc_json_utils();
use Apache::lc_parameters;
use Apache::lc_logs;
use Apache::lc_entity_sessions();

use vars qw($privileges);
require Exporter;
our @ISA = qw (Exporter);
our @EXPORT = qw(allowed_system allowed_course allowed_section allowed_user);

# Check privileges on system-level, going through all system roles
#
sub allowed_system {
   my ($action)=@_;
   my $roles=&Apache::lc_entity_sessions::roles();
   foreach my $role (keys(%{$roles->{'system'}})) {
      if ($privileges->{$roles}->{'system'}->{$action}) { return 1; }
   }
   return 0;
}

# Check privileges on domain-level and above
#
sub allowed_domain {
   my ($action,$domain)=@_;
   if (&allowed_system($action)) { return 1; }
   my $roles=&Apache::lc_entity_sessions::roles();
   foreach my $role (keys(%{$roles->{'domain'}->{$domain}})) {
      if ($privileges->{$roles}->{'domain'}->{$action}) { return 1; }
   }
   return 0;
}

# Check privileges on course-level and above
#
sub allowed_course {
   my ($action,$entity,$domain)=@_;
   if (&allowed_domain($action,$domain)) { return 1; }
   my $roles=&Apache::lc_entity_sessions::roles();
   foreach my $role (keys(%{$roles->{'course'}->{$domain}->{$entity}->{'any'}})) {
      if ($privileges->{$role}->{'course'}->{$action}) { return 1; }
   }
   return 0;
}

# Check privileges on section-level and above
# 
sub allowed_section {
   my ($action,$entity,$domain,$section)=@_;
   if (&allowed_course($action,$entity,$domain)) { return 1; }
   my $roles=&Apache::lc_entity_sessions::roles();
   foreach my $role (keys(%{$roles->{'course'}->{$domain}->{$entity}->{'section'}->{$section}})) {
      if ($privileges->{$role}->{'section'}->{$action}) { return 1; }
   }
   return 0;
}

# Check privileges on user-level and above
#
sub allowed_user {
   my ($action,$entity,$domain)=@_;
   if (&allowed_domain($action,$domain)) { return 1; }
   my $roles=&Apache::lc_entity_sessions::roles();
   foreach my $role (keys(%{$roles->{'user'}->{$domain}->{$entity}})) {
      if ($privileges->{$role}->{'user'}->{$action}) { return 1; }
   }
   return 0;
}


BEGIN {
   unless ($privileges) {
      $privileges=&Apache::lc_json_utils::json_to_perl(&Apache::lc_file_utils::readfile(&lc_roles_defs()));
      if ($privileges) {
         &lognotice("Loaded roles definitions");
      } else {
         &logerror("Could not load roles definitions");
      } 
   }
}

1;
__END__
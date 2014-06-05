# install CentOS 6.5 minimal
# configure network interface (/etc/sysconfig/network-scripts/ifcfg-eth0)
# yum update
# reboot
# make dev-install
# ...get a coffee
# make install

DBNAME = loncapa
DBUSER = loncapa

LC_USER = apache
LC_GROUP = apache

INSTALL = /usr/bin/install
CREATEUSER = 

DESTDIR = /home/loncapa
LC_CERTS_PATH = $(DESTDIR)/certs
LC_CLUSTER_PATH = $(DESTDIR)/cluster
LC_LOG_PATH = $(DESTDIR)/logs
LC_RESOURCE_PATH = $(DESTDIR)/res
#TODO naming
LC_WRK_PATH = $(DESTDIR)/wrk
LC_CONF_PATH = $(DESTDIR)/conf

HTTPD_PATH = /home/httpd
HTTPD_LIBS_PATH = $(HTTPD_PATH)/lib/perl/Apache
HTTPD_CONF_PATH = /etc/httpd/conf
HTTPD_CONFD_PATH = /etc/httpd/conf.d
HTTPD_LOCALIZE_PATH = $(HTTPD_LIBS_PATH)/lc_localize
HTTPD_HTML_PATH = $(HTTPD_PATH)/html
HTTPD_IMAGES_PATH = $(HTTPD_HTML_PATH)/images
HTTPD_SCRIPTS_PATH = $(HTTPD_HTML_PATH)/scripts
HTTPD_CSS_PATH = $(HTTPD_HTML_PATH)/css
HTTPD_PAGES_PATH = $(HTTPD_HTML_PATH)/pages
HTTPD_MODAL_PATH = $(HTTPD_HTML_PATH)/modals
HTTPD_HELP_PATH = $(HTTPD_HTML_PATH)/help

#TODO verify permissions are correct
#TODO replace cp with install
#TODO packages that need to be installed: httpd
#TODO Term::Readline expects user input during one of the tests 
all: default
	
default: 
	@echo "Please read the documentation"

install: init-dirs install-files init-database start-services

init-database: 
	createuser -S -d -R -e -U postgres $(DBUSER)
	createdb -O loncapa -e -U $(DBUSER) $(DBNAME)
	psql -f relations.sql $(DBNAME) loncapa 

init-dirs:
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(LC_CERTS_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(LC_CLUSTER_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(LC_LOG_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(LC_RESOURCE_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(LC_WRK_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_LOCALIZE_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_SCRIPTS_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_PAGES_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_MODAL_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_HELP_PATH)

install-files: install-libs install-conf install-static

install-libs:
	[ -d $(HTTPD_LIBS_PATH) ] || $(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_LIBS_PATH) 
	cp ../connections/*.pm $(HTTPD_LIBS_PATH)
	cp ../xml/*.pm $(HTTPD_LIBS_PATH)
	cp ../xml/xml_tag_defs/*.pm $(HTTPD_LIBS_PATH)
	cp ../xml/xml_includes/*.pm $(HTTPD_LIBS_PATH)
	cp ../json/*.pm $(HTTPD_LIBS_PATH)
	cp ../file_handling/*.pm $(HTTPD_LIBS_PATH)
	cp ../app/handlers/*.pm $(HTTPD_LIBS_PATH)
	cp ../app/handlers/lc_localize/*.pm $(HTTPD_LOCALIZE_PATH)
	cp ../auth/*.pm $(HTTPD_LIBS_PATH)
	cp ../databases/*.pm $(HTTPD_LIBS_PATH)
	cp ../entities/*.pm $(HTTPD_LIBS_PATH)
	cp ../test/lc_test.pm $(HTTPD_LIBS_PATH)
	cp ../conf/lc_parameters.pm $(HTTPD_LIBS_PATH)

install-static:
	[ -d $(HTTPD_HTML_PATH) ] || $(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_HTML_PATH) 
	cp ../app/favicon.ico $(HTTPD_HTML_PATH)
	cp ../app/html/*.html $(HTTPD_HTML_PATH)
	[ -d $(HTTPD_IMAGES_PATH) ] || $(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_IMAGES_PATH) 
	cp ../app/images/* $(HTTPD_IMAGES_PATH)
	[ -d $(HTTPD_SCRIPTS_PATH) ] || $(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_SCRIPTS_PATH) 
	-(cd ../app/scripts && find . -type d -print) | while read dir; do \
		$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d "$(HTTPD_SCRIPTS_PATH)/$$dir"; \
	done
	-(cd ../app/scripts && find . -type f -print) | while read file; do \
		$(INSTALL) -m 644 -o $(LC_USER) -g $(LC_GROUP) "../app/scripts/$$file" "$(HTTPD_SCRIPTS_PATH)/$$file"; \
	done
	-(cd ../app/css && find . -type d -print) | while read dir; do \
		$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d "$(HTTPD_CSS_PATH)/$$dir"; \
	done
	-(cd ../app/css && find . -type f -print) | while read file; do \
		$(INSTALL) -m 644 -o $(LC_USER) -g $(LC_GROUP) "../app/css/$$file" "$(HTTPD_CSS_PATH)/$$file"; \
	done
	-(cd ../app/html/pages && find . -type f -print) | while read file; do \
		$(INSTALL) -m 644 -o $(LC_USER) -g $(LC_GROUP) "../app/html/pages/$$file" "$(HTTPD_PAGES_PATH)/$$file"; \
	done
	-(cd ../app/html/modals && find . -type f -print) | while read file; do \
		$(INSTALL) -m 644 -o $(LC_USER) -g $(LC_GROUP) "../app/html/modals/$$file" "$(HTTPD_MODAL_PATH)/$$file"; \
	done
	-(cd ../app/html/help && find . -type f -print) | while read file; do \
		$(INSTALL) -m 644 -o $(LC_USER) -g $(LC_GROUP) "../app/html/help/$$file" "$(HTTPD_HELP_PATH)/$$file"; \
	done

install-conf:
	[ -d $(LC_CONF_PATH) ] || $(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(LC_CONF_PATH)
	cp ../conf/{httpd.conf,lc_startup.pl} $(HTTPD_CONF_PATH)
	cp ../conf/{ssl.conf,lc.conf} $(HTTPD_CONFD_PATH)
	cp ../conf/roles.json $(LC_CONF_PATH)
	cp ../conf/cluster/cluster_manager.conf $(LC_CLUSTER_PATH)

start-services:
	service httpd start
	
clean: stop-services clean-database clean-files

stop-services:
	service httpd stop
	service postgresql stop
	service mongod stop
	service memcached stop

clean-database:
	rm -rf /var/lib/pgsql/data

clean-files:
	rm -rf $(DESTDIR)
	rm -rf $(HTTPD_PATH)
	@echo "TODO restore httpd conf"
	rm -f $(HTTPD_CONF_PATH)/lc_startup.pl
	rm -f $(HTTPD_CONFD_PATH)/ssl.conf
	rm -f $(HTTPD_CONFD_PATH)/lc.conf

#targets named dev-* are not considered end-user ready
dev-install: dev-install-yum-dep dev-install-cpan-dep dev-config-db dev-config-services dev-start-services dev-install-certs dev-verify-install

dev-install-yum-dep:
	yum -y install perl man ntp httpd openssl-devel mod_ssl mod_perl postgresql \
		postgresql-server perl-DBD-Pg memcached perl-CPAN gcc
	$(INSTALL) -m 644 mongodb.repo /etc/yum.repos.d/
	yum -y install mongo-10gen mongo-10gen-server

dev-install-cpan-dep:
#	-PERL_MM_USE_DEFAULT=1 cpan Bundle::CPAN
#	-PERL_MM_USE_DEFAULT=1 cpan Bundle::LONCAPA
	curl -L http://cpanmin.us | perl - --self-upgrade
	cpanm --installdeps .

dev-start-services:
	service memcached start
	service postgresql start 
	service mongod start

dev-config-services:
#TODO provide policy for SELinux
	setenforce 0 
	sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux
	chkconfig httpd on
	chkconfig postgresql on
	chkconfig mongod on
	chkconfig memcached on

dev-config-db: 
	service postgresql initdb
	$(INSTALL) -m 600 -o postgres -g postgres ../conf/pg_hba.conf /var/lib/pgsql/data/

dev-install-certs: init-dirs
#TODO generate certs instead of storing them in version control 
	install -m 600 -o $(LC_USER) -g $(LC_GROUP) "../testcerts/client.key" $(LC_CERTS_PATH)
	install -m 600 -o $(LC_USER) -g $(LC_GROUP) "../testcerts/client.crt" $(LC_CERTS_PATH)
	install -m 600 -o $(LC_USER) -g $(LC_GROUP) "../testcerts/localhost.key" $(LC_CERTS_PATH)/server.key
	install -m 600 -o $(LC_USER) -g $(LC_GROUP) "../testcerts/localhost.crt" $(LC_CERTS_PATH)/server.crt
	install -m 600 -o $(LC_USER) -g $(LC_GROUP) "../testcerts/LONCAPA.crt" $(LC_CERTS_PATH)
	install -m 644 -o $(LC_USER) -g $(LC_GROUP) "../testcerts/makelocal.conf" $(HTTPD_CONFD_PATH)
	install -m 644 -o $(LC_USER) -g $(LC_GROUP) "../testcerts/cluster_table.json" $(LC_CLUSTER_PATH)
	
	
dev-verify-install:
	@echo "#TODO implement verification of installation"

.PHONY: install init-database init-dirs install-files install-libs \
	install-static install-conf clean clean-database clean-dirs \
	dev-install dev-install-yum-dep dev-install-cpan-dep \
	dev-start-services dev-config-db dev-verify-install
	

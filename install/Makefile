
DBNAME = loncapa
DBUSER = loncapa

INSTALL = /usr/bin/install

LC_USER = apache
LC_GROUP = apache

DESTDIR = /home/loncapa
LC_CERTS_PATH = certs
LC_CLUSTER_PATH = cluster
LC_LOG_PATH = logs
LC_RESOURCE_PATH = res
#TODO naming
LC_WRK_PATH = wrk
LC_CONF_PATH = $(DESTDIR)/conf

HTTPD_PATH = /home/httpd
HTTPD_LIBS_PATH = $(HTTPD_PATH)/lib/perl/Apache
HTTPD_CONF_PATH = /etc/httpd/conf.d
HTTPD_LOCALIZE_PATH = $(HTTPD_LIBS_PATH)/lc_localize
HTTPD_HTML_PATH = $(HTTPD_PATH)/html
HTTPD_IMAGES_PATH = $(HTTPD_HTML_PATH)/images
HTTPD_SCRIPTS_PATH = $(HTTPD_HTML_PATH)/scripts

#TODO verify permissions are correct
#TODO replace cp with install
#TODO packages that need to be installed: httpd
all: default
	
default: 
	@echo "Please read the documentation"

install: init-dirs install-files init-database

init-database: 
	createuser -S -D -R -e $(DBUSER)
	createdb -O loncapa -e $(DBNAME)
	psql $(DBNAME) loncapa -f relations.sql

init-dirs:
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(DESTDIR)/$(LC_CERTS_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(DESTDIR)/$(LC_CLUSTER_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(DESTDIR)/$(LC_LOG_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(DESTDIR)/$(LC_RESOURCE_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(DESTDIR)/$(LC_WRK_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_LOCALIZE_PATH)
	$(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_SCRIPTS_PATH)

install-files: install-libs install-conf install-static
	cp ../app/handlers/lc_localize/*.pm $(HTTPD_LOCALIZE_PATH)

install-libs:
	[ -d $(HTTPD_LIBS_PATH) ] || $(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(HTTPD_LIBS_PATH) 
	cp ../connections/*.pm $(HTTPD_LIBS_PATH)
	cp ../xml/*.pm $(HTTPD_LIBS_PATH)
	cp ../xml/xml_tag_defs/*.pm $(HTTPD_LIBS_PATH)
	cp ../xml/xml_includes/*.pm $(HTTPD_LIBS_PATH)
	cp ../json/*.pm $(HTTPD_LIBS_PATH)
	cp ../file_handling/*.pm $(HTTPD_LIBS_PATH)
	cp ../app/handlers/*.pm $(HTTPD_LIBS_PATH)
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
	-(cd app/scripts && find . -type d -print) | while read dir; do \
		$(INSTALL) -m 755 -d "$(HTTPD_SCRIPTS_PATH)/$$dir"; \
	done
	-(cd app/scripts && find . -type f -print) | while read file; do \
		$(INSTALL) -m 755 "app/scripts/$$file" "$(HTTPD_SCRIPTS_PATH)/$$file"; \
	done

install-conf:
	[ -d $(LC_CONF_PATH) ] || $(INSTALL) -m 755 -o $(LC_USER) -g $(LC_GROUP) -d $(LC_CONF_PATH)
	cp ../conf/{httpd.conf,ssl.conf,lc.conf,lc_startup.pl} $(HTTPD_CONF_PATH)
	cp ../conf/roles.json $(LC_CONF_PATH)

	
clean: clean-dirs clean-database

clean-database:
	dropdb $(DBNAME)

clean-dirs:
	rm -rf $(DESTDIR)
	rm -rf $(HTTPD_LIBS_PATH)

#targets named dev-* are not considered end-user ready
dev-install: dev-install-yum-dep dev-install-cpan-dep dev-config-db dev-config-services dev-start-services

dev-install-yum-dep:
	yum -y install man ntp httpd openssl-devel mod_ssl mod_perl postgresql \
		postgresql-server perl-DBD-Pg memcached perl-CPAN gcc
	chkconfig httpd on
	$(INSTALL) -m 644 mongodb.repo /etc/yum.repos.d/
	yum install mongo-10gen mongo-10gen-server

dev-install-cpan-dep:
	PERL_MM_USE_DEFAULT=1 cpan Bundle::LONCAPA

dev-start-services:
	service memcached start
	service postgresql start 
	service mongod start

dev-config-services:
	chkconfig postgresql on
	chkconfig mongod on
	chkconfig memcached on

dev-config-db: 
	$(INSTALL) -m 600 -o postgres -u postgres /var/lib/pgsql/data/
	service postgresql initdb

.PHONY: install init-database init-dirs install-files install-libs install-static install-conf clean clean-database clean-dirs
	

cd ..
mkdir /home/loncapa
mkdir /home/loncapa/certs
mkdir /home/loncapa/cluster
mkdir /home/loncapa/logs
mkdir /home/loncapa/res
mkdir /home/loncapa/wrk
mkdir /home/loncapa/conf
chown -R www:www /home/loncapa
mkdir /home/httpd
mkdir /home/httpd/lib
mkdir /home/httpd/lib/perl
mkdir /home/httpd/lib/perl/Apache
rm /home/httpd/lib/perl/Apache/*
cp connections/*.pm /home/httpd/lib/perl/Apache
cp xml/*pm /home/httpd/lib/perl/Apache
cp xml/xml_tag_defs/*.pm /home/httpd/lib/perl/Apache
cp xml/xml_includes/*.pm /home/httpd/lib/perl/Apache
cp json/*.pm /home/httpd/lib/perl/Apache
cp file_handling/*.pm /home/httpd/lib/perl/Apache
cp conf/httpd.conf /etc/httpd/conf
cp conf/ssl.conf /etc/httpd/conf.d
cp conf/lc.conf /etc/httpd/conf.d
cp conf/lc_startup.pl /etc/httpd/conf
cp conf/lc_parameters.pm /home/httpd/lib/perl/Apache
cp conf/roles.json /home/loncapa/conf
cp conf/units.json /home/loncapa/conf
cp conf/constants.json /home/loncapa/conf
cp app/handlers/*pm /home/httpd/lib/perl/Apache
mkdir /home/httpd/lib/perl/Apache/lc_localize
rm /home/httpd/lib/perl/Apache/lc_localize/*
cp app/handlers/lc_localize/*.pm /home/httpd/lib/perl/Apache/lc_localize
cp auth/*.pm /home/httpd/lib/perl/Apache
cp databases/*.pm /home/httpd/lib/perl/Apache
cp entities/*.pm /home/httpd/lib/perl/Apache
cp test/lc_test.pm /home/httpd/lib/perl/Apache
cp test/math_parser_manual_test.pl /home/httpd/lib/perl/Apache
cp test/math_parser_test_cases.pl /home/httpd/lib/perl/Apache
cp -r math /home/httpd/lib/perl/Apache/
mkdir /home/httpd/lib/perl/Apache/xml_problem_tags
cp xml/xml_problem_tags/*.pm /home/httpd/lib/perl/Apache/xml_problem_tags
mkdir /home/httpd/html
cp app/favicon.ico /home/httpd/html
cp app/html/*.html /home/httpd/html
mkdir /home/httpd/html/images
cp app/images/* /home/httpd/html/images
mkdir /home/httpd/html/scripts
if [ ! -d /home/httpd/html/scripts/mathjax ]; then
   unzip app/scripts/v2.3-latest -d /home/httpd/html/scripts
   mv /home/httpd/html/scripts/mathjax* /home/httpd/html/scripts/mathjax 
fi
if [ ! -d /home/httpd/html/scripts/ckeditor ]; then
   unzip app/scripts/ckeditor.zip -d /home/httpd/html/scripts
fi
if [ ! -d /home/httpd/html/scripts/datepick ]; then
   unzip app/scripts/datepick.zip -d /home/httpd/html/scripts/datepick
fi
cp app/scripts/ckeditor/config.js /home/httpd/html/scripts/ckeditor
cp app/scripts/jquery* /home/httpd/html/scripts
cp app/scripts/lc* /home/httpd/html/scripts
cp -R app/scripts/jstree /home/httpd/html/scripts/
cp app/scripts/maxima_editor/dist/maxima_editor.min.js /home/httpd/html/scripts/
chown -R www:www /home/httpd/html/scripts/*
chmod -R a+rx /home/httpd/html/scripts/*
mkdir /home/httpd/html/css
cp app/css/* /home/httpd/html/css
mkdir /home/httpd/html/pages
cp app/html/pages/* /home/httpd/html/pages
mkdir /home/httpd/html/modals
cp app/html/modals/* /home/httpd/html/modals
mkdir /home/httpd/html/help
cp app/html/help/* /home/httpd/html/help
if [ ! -e /home/loncapa/cluster/cluster_manager.conf ]; then
   cp conf/cluster/cluster_manager.conf /home/loncapa/cluster
fi
/etc/init.d/httpd restart

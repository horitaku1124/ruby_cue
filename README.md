Ruby Cue
==========================

How to install

    $ useradd rubycue -u 50001 -s /sbin/nologin
    $ mkdir /var/log/ruby_cue
    $ chown rubycue. /var/log/ruby_cue
    $ cp cued /etc/init.d/
    $ chmod +x /usr/local/bin/ruby_cue/cue_start.sh
    $ mkdir /var/lock/subsys

How to start

    $ ruby start_by_fork.rb /tmp/ruby_cue.pid

How to stop

    $ kill `cat /tmp/ruby_cue.pid`

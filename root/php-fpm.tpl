#!/bin/bash

# See: https://www.bountysource.com/issues/8490193-fix-long-messages-to-stdout-stderr-getting-truncated
# And: https://github.com/docker-library/php/issues/207#issuecomment-276296087
# And: https://groups.google.com/forum/#!topic/highload-php-en/VXDN8-Ox9-M
# And: http://veithen.github.io/2014/11/16/sigterm-propagation.html

trap 'kill -TERM $PID' TERM INT

php-fpm{{ getenv "PHP_VERSION" }} --fpm-config /etc/php/{{ getenv "PHP_VERSION" }}/fpm/php-fpm.conf --force-stderr 2> >(sed -u -E -e 's/^\[[^]]+\] WARNING: \[pool [^]]+\] child [0-9]+ said into std(err|out): "(.*)("|...)$/\2\3/' -e 's/"$//') &

PID=$!

wait $PID

trap - TERM INT

wait $PID

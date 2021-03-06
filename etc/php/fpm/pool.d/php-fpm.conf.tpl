[global]

; Pid file
pid = /run/php-fpm.pid

; Error log file
error_log = /proc/self/fd/2

; Log level
; Possible Values: alert, error, warning, notice, debug
log_level = {{ getenv "PHP_FPM_POOL_LOG_LEVEL" "warning" }}

; Send FPM to background
daemonize = no

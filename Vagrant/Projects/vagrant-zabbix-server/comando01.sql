create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix identified by 'zabbix';
use zabbix;
grant all privileges on zabbix.* to zabbix;
set global log_bin_trust_function_creators = 1;
commit;
quit
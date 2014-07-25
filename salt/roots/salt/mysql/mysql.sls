#my.cnf:
#  file.managed:
#    - name: /etc/mysql/my.cnf
#    - source: salt://mysql/my.cnf
#    - user: root
#    - group: root
#    - mode: 644
#    - require:
#      - pkg: mysql-client
#      - pkg: mysql-server
#      - pkg: python-mysqldb

mysql-client:
  pkg.installed

mysql-server:
  pkg.installed

python-mysqldb:
  pkg.installed

mysql_service:
  service:
    - name: mysql
    - running
    - enable: True
    - reload: True
    - require:
      - pkg: mysql-server

cmsuser:
  mysql_user.present:
    - host: localhost
    - password: password
    - require:
      - service: mysql_service
      - pkg: python-mysqldb
      - mysql_database: cmsdb

cmsdb:
  mysql_database.present:
    - character_set: utf8
    - collate: utf8_danish_ci
    - require:
      - pkg: python-mysqldb
      - service: mysql_service

cmsuser_cmsdb:
  mysql_grants.present:
    - grant: all
    - database: cmsdb.*
    - user: cmsuser
    - require:
      - service: mysql_service
      - pkg: python-mysqldb
      - mysql_user: cmsuser
      - mysql_database: cmsdb

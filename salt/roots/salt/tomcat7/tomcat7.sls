debconf-utils:
  pkg:
    - installed
    
tomcat7:       
  pkg:         
    - installed    
    - require:
      - pkg: debconf-utils
      
  service.running:
    - enable: True      
    - name: tomcat7
    - watch:
      - file: /etc/tomcat7/server.xml

server.xml:
  file.managed:
    - name: /etc/tomcat7/server.xml
    - source: salt://tomcat7/server.xml
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: tomcat7

catalina.sh:
  file.managed:
    - name: /usr/share/tomcat7/bin/catalina.sh
    - source: salt://tomcat7/catalina.sh
    - user: root
    - group: root
    - mode: 777
    - require:
      - pkg: tomcat7

tomcat_configuration:
  file.append:
    - name: /etc/default/tomcat7
    - text: JAVA_HOME="/usr/lib/jvm/java-7-oracle"
    - require:
          - pkg: tomcat7

# This is used in mysql setup. Move to dbdriver.sh?

#getdbdriver:
#    cmd.run:
#    - creates: /vagrant/mysql-connector.jar
#    - name: |
#        curl -O curl -L -o /vagrant/mysql-connector.jar  https://www.dropbox.com/s/nfdzhpw9p0rtb5g/mysql-connector-java-5.1.31-bin.jar?dl=1
#    - mode: 777
#    - user: root
#    - group: root

#movedbdriver:
#    cmd.script:
#    - source: salt://tomcat7/dbdriver.sh
#    - cwd: /vagrant/
#    - mode: 777
#    - user: root
#    - group: root

postgresql_jdbc:
    pkg.installed:
        - name: libpostgresql-jdbc-java
        - require:
          - pkg: tomcat7

/usr/share/tomcat7/lib/postgresql-jdbc3.jar:
  file.symlink:
    - target: /usr/share/java/postgresql-jdbc3.jar
    - user: root
    - group: root
    - require:
      - pkg: postgresql_jdbc



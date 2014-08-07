enonic:
  cmd.run:
    - creates: /var/lib/tomcat7/webapps/ROOT.war
    #- unless: [ ! exit -f /var/lib/tomcat7/webapps/ROOT.war ]
    - name: |
        # Download the enonic zip file, unzip and change the name to CMS.HOME
        curl -O curl -L -o enonic-4.7.6.zip  https://www.dropbox.com/s/fkztrltqb5qa6wh/cms-ce-distro-4.7.6.zip?dl=1
        unzip -u /vagrant/enonic-4.7.6.zip && mv /vagrant/cms-ee-distro-4.7.6 /vagrant/cms.home

        # Delete the dummy webapp from tomcat and copy the enonic war file and change the name to ROOT.war
        sudo rm -rf /var/lib/tomcat7/webapps/ROOT
        sudo cp /vagrant/cms.home/webapp/cms.war /var/lib/tomcat7/webapps
        sudo mv /var/lib/tomcat7/webapps/cms.war /var/lib/tomcat7/webapps/ROOT.war

        # Delete the zip file
        sudo rm /vagrant/enonic-4.7.6.zip
    - cwd: /vagrant/
    - user: vagrant
    - group: vagrant
    - require:
      - pkg: enonic_req
      - pkg: tomcat7

enonic_req:
  pkg.installed:
    - names:
      - curl
      - unzip
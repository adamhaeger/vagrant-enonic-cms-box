enonic:
  cmd.run:
    - creates: /var/lib/tomcat7/webapps/ROOT.war
    - name: |
        #curl -O curl -L -o enonic-4.7.6.zip  https://www.dropbox.com/s/fkztrltqb5qa6wh/cms-ce-distro-4.7.6.zip?dl=1
        #unzip -u enonic-4.7.6.zip && mv cms-ce-distro-4.7.6 cms
        sudo cp /vagrant/cms/webapp/cms.war /var/lib/tomcat7/webapps
        sudo mv /var/lib/tomcat7/webapps/cms.war /var/lib/tomcat7/webapps/ROOT.war
    - cwd: /vagrant/
    - user: vagrant
    - group: vagrant
    - require:
      - pkg: enonic_req

#remove_play:
  #  file.absent:
    #  - user: vagrant
    #- group: vagrant
    #- names:
      #  - /home/vagrant/play-2.1.2
      #- /home/vagrant/play-2.1.2.zip

#/vagrant/bin:
#  file.directory:
#    - user: vagrant
#    - group: vagrant
#    - makedirs: True

#/home/vagrant/bin/play:
#  file.symlink:
#    - target: /home/vagrant/play-2.1.2/play
#    - user: vagrant
#    - group: vagrant
#    - require:
#      - cmd: download_play
#      - file: /home/vagrant/bin

PATH_bin:
  file.append:
    - name: /etc/profile
    - text: export CMS_HOME=/vagrant/cms/home

enonic_req:
  pkg.installed:
    - names:
      - curl
      - unzip
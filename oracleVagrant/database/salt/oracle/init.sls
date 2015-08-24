#TODO: unzip install files from vagrant provided directory
#TODO: Initialize pillars with vagrant. Pillars supply the paths
#TODO: All other files should be pulled from git
#TODO: Install files should be retrieved and unzipped from vagrant provdided directory

db_dependencies:
  pkg.installed:
    - pkgs:
        - libaio
        - glibc
        - compat-libstdc++-33
        - elfutils-libelf-devel
        - gcc-c++
        - libaio-devel
        - libgcc
        - libstdc++
        - libstdc++-devel
        - unixODBC
        - unixODBC-devel
        - mksh
        #- pdksh not needed see note: 1962046.1

oracle:
  user.present:
    - fullname: oracle
    - shell: /bin/sh
    - home: /home/oracle
    - empty_password: True

        
oinstall:
  group.present:
      - addusers:
          - oracle
        
/opt/oracle:
  file.directory:
    - user: oracle
    - group: oinstall
    - mode: 770
    - require:
      - group: oinstall
        
isntall_db:
  cmd.run:
    - name: /stage/database/runInstaller -ignorePrereq -silent -responseFile /stage/rsp_files/db_recorded.rsp
    - cwd: /stage/database
    - onlyif: ls /opt/oracle/app/oracle/product/11.2.0/dbhome_1/bin/sqlplus
    - user: oracle

/opt/oracle/app/oraInventory/orainstRoot.sh:
  cmd.run

/opt/oracle/app/oracle/product/11.2.0/dbhome_1/root.sh:
  cmd.run
    
### mongoDB-container

#### Create mongodb dockerFile to build mongodb using dockerfile.

    # docker build -t mondodb.new
    
#### Check the image out   

    # docker images
      REPOSITORY                                 TAG                 IMAGE ID            CREATED              SIZE
      mondodb.new                                latest              9bf4be986323        About a minute ago   759 MB

#### Run it

    # docker run -i -t mondodb.new /bin/bash
    [root@30eb123ed34e /]# 
    
#### Check mongod services running or not

    [root@30eb123ed34e /]# ps -ef | grep mongo
    root        22     1  1 10:47 ?        00:00:19 mongod
    root       146     1  0 11:12 ?        00:00:00 grep --color=auto mongo
    
#### configure bindip to mongod.conf file

    [root@30eb123ed34e /]# vi /etc/mongod.conf
    bindIp: 172.17.0.2
    
#### Run mongod services

    [root@30eb123ed34e /]# /usr/bin/mongod  -f /etc/mongod.conf 
    2018-12-12T11:13:35.358+0000 I CONTROL  [main] Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'
    about to fork child process, waiting until server is ready for connections.
    forked process: 156
    child process started successfully, parent exiting
    
#### Verify mongod services runnning or nor using below command.

    [root@30eb123ed34e /]# ps -ef | grep mongod
    root        22     1  1 10:47 ?        00:00:19 mongod
    root       156     1 14 11:13 ?        00:00:29 /usr/bin/mongod -f /etc/mongod.conf
    root       191     1  0 11:16 ?        00:00:00 grep --color=auto mongod
    
#### Login into mongoDB shell

    [root@30eb123ed34e mongodb]# mongo 172.17.0.2:27017
    MongoDB shell version v4.0.4
    connecting to: mongodb://172.17.0.2:27017/test
    Implicit session: session { "id" : UUID("de7f1991-4658-4f32-b231-c554f39ce3db") }
    MongoDB server version: 4.0.4
    Welcome to the MongoDB shell.
    For interactive help, type "help".
    For more comprehensive documentation, see
      http://docs.mongodb.org/
    Questions? Try the support group
      http://groups.google.com/group/mongodb-user
    Server has startup warnings: 
    2018-12-12T11:13:51.473+0000 I CONTROL  [initandlisten] 
    2018-12-12T11:13:51.474+0000 I CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
    2018-12-12T11:13:51.474+0000 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
    2018-12-12T11:13:51.474+0000 I CONTROL  [initandlisten] ** WARNING: You are running this process as the root user, which is not recommended.
    2018-12-12T11:13:51.474+0000 I CONTROL  [initandlisten] 
    2018-12-12T11:13:51.499+0000 I CONTROL  [initandlisten] 
    2018-12-12T11:13:51.499+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/enabled is 'always'.
    2018-12-12T11:13:51.499+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
    2018-12-12T11:13:51.500+0000 I CONTROL  [initandlisten] 
    2018-12-12T11:13:51.500+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/defrag is 'always'.
    2018-12-12T11:13:51.501+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
    2018-12-12T11:13:51.501+0000 I CONTROL  [initandlisten] 
    ---
    Enable MongoDB's free cloud-based monitoring service, which will then receive and display
    metrics about your deployment (disk utilization, CPU, operation statistics, etc).

    The monitoring data will be available on a MongoDB website with a unique URL accessible to you
    and anyone you share the URL with. MongoDB may use this information to make product
    improvements and to suggest MongoDB products and deployment options to you.

    To enable free monitoring, run the following command: db.enableFreeMonitoring()
    To permanently disable this reminder, run the following command: db.disableFreeMonitoring()
    ---

    > 

#### Verify mongoDB version

    > db.version()
    4.0.4

#### To use a database with name (newdb)

    > use newdb
    switched to db newdb
 
#### To check your currently selected database

    > db
    newdb

#### If you want to check your databases list
    > show dbs
    admin   0.000GB
    config  0.000GB
    local   0.000GB
    mukesh  0.000GB

#### Your created database (mewdb) is not present in list. To display database, you need to insert at least one document into it.

    > db.hello.insert({"name":"Mukesh Ramteke"})
    WriteResult({ "nInserted" : 1 })

#### Now Verify 
    > show dbs
    admin   0.000GB
    config  0.000GB
    local   0.000GB
    mukesh  0.000GB
    newdb   0.000GB

#### Create admin user
 
    > db.createUser(
    ...   {
    ...     user: "admin",
    ...     pwd: "admin123",
    ...     roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
    ...   }
    ... )
    Successfully added user: {
      "user" : "admin",
      "roles" : [
        {
          "role" : "userAdminAnyDatabase",
          "db" : "admin"
        }
      ]
    }

#### Verify the user

    > show users
    {
      "_id" : "admin.admin",
      "user" : "admin",
      "db" : "admin",
      "roles" : [
        {
          "role" : "userAdminAnyDatabase",
          "db" : "admin"
        }
      ],
      "mechanisms" : [
        "SCRAM-SHA-1",
        "SCRAM-SHA-256"
      ]
    }
    
#### Allows a user to authenticate to the database from within the shell

    > db.auth('admin', 'admin123')
    1

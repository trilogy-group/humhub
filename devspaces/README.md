# Development with Devspaces

### Devspaces

Manage your Devspaces https://www.devspaces.io/.

Read up-to-date documentation about cli installation and operation in https://www.devspaces.io/devspaces/help.

Here follows the main commands used in Devspaces cli.

|action   |Description                                                                                   |
|---------|----------------------------------------------------------------------------------------------|
|`devspaces --help`                    |Check the available command names.                               |
|`devspaces create [options]`          |Creates a DevSpace using your local DevSpaces configuration file |
|`devspaces start <devSpace>`          |Starts the DevSpace named \[devSpace\]                           |
|`devspaces bind <devSpace>`           |Syncs the DevSpace with the current directory                    |
|`devspaces info <devSpace> [options]` |Displays configuration info about the DevSpace.                  |

Use `devspaces --help` to know about updated commands.

#### Development flow

You should have Devspaces cli services started and logged to develop with Devspaces.
The following commands should be issued from **project directory**.

1 - Create Devspaces

```bash
$ cd devspaces/docker
$ devspaces create
$ cd ../../
```

2 - Start containers

```bash
devspaces start humhubDev
```

3 - Start containers synchronization

```bash
devspaces bind humhubDev
```

4 - Grab some container info

```bash
devspaces info humhubDev
```

Retrieve published DNS and endpoints using this command

5 - Connect to development container

```bash
devspaces exec humhubDev
```

6 - Build Humhub and refresh Apache deploy directory

```bash
composer install
refresh_www_data
```

7 - Run Humhub

```bash
apache2-foreground
```

Access application URLs:

Using information retrieved in step 4, access the following URL's:

* Application (bound to port 80):
    * `http://Humhub.<devspaces-user>.devspaces.io:<published-ports>/`

* Enter Database connection data:

```
host: 127.0.0.1
database: humhub
user: humhub_dbuser
password: humhub_dbpass
```

8 - Configure Tests

8.1 - Bootstrap Test Environment

**After compose install**

```bash
cd /data
/data/protected/vendor/codeception/codeception/codecept bootstrap
```

8.2 - Configure TestDB

Edit connection config file:

```bash
vim /data/protected/humhub/tests/config/common.php
```

With Following attributes:

```php
'dsn' => 'mysql:host=127.0.0.1;dbname=humhub_test',
'username' => 'humhub_dbuser',
'password' => 'humhub_dbpass',
```

8.3 - Initialize TestDB

```bash
cd /data/protected/humhub/tests/codeception/bin
php yii migrate/up --includeModuleMigrations=1 --interactive=0
php yii installer/auto
```

8.4 - Run Tests

```bash
cd /data/protected/humhub/tests/
/data/protected/vendor/codeception/codeception/codecept run unit
```

### Docker Script Manager (CLI)

Currently, we have these command available to work using local docker compose.

```bash
devspaces/docker-cli.sh <command>
```

|action    |Description                                                               |
|----------|--------------------------------------------------------------------------|
|`build`   |Builds images                                                             |
|`deploy`  |Deploy Docker compose containers                                          |
|`undeploy`|Undeploy Docker compose containers                                        |
|`start`   |Starts Docker compose containers                                          |
|`stop`    |Stops Docker compose containers                                           |
|`exec`    |Get into the container                                                    |

#### Development flow

1 - Build and Run `docker-compose` locally.

```bash
devspaces/docker-cli.sh build
devspaces/docker-cli.sh deploy
devspaces/docker-cli.sh start
```

2 - Get into container

```bash
devspaces/docker-cli.sh exec
```

3 - Build Humhub and refresh Apache deploy directory

```bash
composer install
refresh_www_data
```

4 - Run Humhub

```bash
apache2-foreground
```

Access application URLs:

* Application (bound to port 80):
    * http://localhost/

* Enter Database connection data:

```
host: 127.0.0.1
database: humhub
user: humhub_dbuser
password: humhub_dbpass
```

5 - Configure Tests

5.1 - Bootstrap Test Environment

**After compose install**

```bash
cd /data
/data/protected/vendor/codeception/codeception/codecept bootstrap
```

5.2 - Configure TestDB

Edit connection config file:

```bash
vim /data/protected/humhub/tests/config/common.php
```

With Following attributes:

```php
'dsn' => 'mysql:host=127.0.0.1;dbname=humhub_test',
'username' => 'humhub_dbuser',
'password' => 'humhub_dbpass',
```

5.3 - Initialize TestDB

```bash
cd /data/protected/humhub/tests/codeception/bin
php yii migrate/up --includeModuleMigrations=1 --interactive=0
php yii installer/auto
```

5.4 - Run Tests

```bash
cd /data/protected/humhub/tests/
/data/protected/vendor/codeception/codeception/codecept run unit
```

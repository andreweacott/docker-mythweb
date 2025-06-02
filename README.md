# MythWeb Docker Image

This repository provides a Dockerized version of **MythWeb**, the classic web frontend for [MythTV](https://www.mythtv.org/).

Since MythWeb has been deprecated in recent MythTV releases and is no longer included in the v35+ ubuntu packages, this image helps continue hosting it in a convenient, containerized way.

> 🛠️ **Note:** You must have a working MythTV backend and accessible database for MythWeb to function.

---

## 🐳 Quick Start

### Environment Variables

The container requires the following environment variables:

| NAME | DESCRIPTION |
|---|---|
| db_server | IP / Hostname of the MySQL server |
| db_name | Name of the MySQL daatabase (most likely 'mythconverg') |
| db_login | MySQL database username |
| db_password | MySQL database password |

### Running in Docker

To run the container manually with Docker:

```bash
docker run --rm \
  -e db_server=<DB_SERVER_IP> \
  -e db_name=<DB_NAME> \
  -e db_login=<DB_USERNAME> \
  -e db_password=<DB_PASSWORD> \
  -p 8080:80 \
  adventuresintech/mythweb-docker:<version>
  ```

### Running in Docker Compose
```yaml
version: '3.8'

services:
  mythweb:
    image: adventuresintech/mythweb-docker:<version>
    container_name: mythweb
    ports:
      - "8080:80"
    environment:
      db_server: <DB_SERVER_IP>
      db_name: <DB_NAME>
      db_login: <DB_USERNAME>
      db_password: <DB_PASSWORD>
    restart: unless-stopped
```
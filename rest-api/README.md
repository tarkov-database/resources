# REST API

## Local development server

Containerized [REST API](https://github.com/tarkov-database/rest-api) server for local development on a Linux system.

### Prerequisites

- [Podman](https://podman.io/getting-started/installation) (>=v2)
- [jq](https://stedolan.github.io/jq/download/)
- cURL

### Set up

#### 1. Clone the repository

```BASH
git clone git@github.com:tarkov-database/resources.git && cd resources/rest-api
```

#### 2. Run the setup script

```BASH
sh pod-setup.sh
```

If everything worked, the API should now be accessible via <http://localhost:9000>

**Enjoy! :-)**

### Usage

You can start the server with

```BASH
podman pod start rest-api
```
or stop with
```BASH
podman pod stop rest-api
```

To remove the server
```BASH
podman pod rm rest-api
```

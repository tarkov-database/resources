# REST API

## Local development server

Containerized [REST API](https://github.com/tarkov-database/rest-api) server for local development on a Linux system.

### Prerequisites

-  [Podman](https://github.com/containers/libpod/blob/master/install.md)
-  [jq](https://stedolan.github.io/jq/download/)
-  cURL

### Usage

**1. Clone the repository**
```BASH
git clone git@github.com:tarkov-database/resources.git
```

**2. Change to this directory**
```BASH
cd resources/rest-api
```

**3. Run the setup script**
```BASH
sh pod-setup.sh
```
*On most systems no root should be required!*

If everything worked, the API should now be accessible via http://localhost:9000

**Enjoy! :-)**

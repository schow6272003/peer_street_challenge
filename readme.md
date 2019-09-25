# PeerStreet Population Estimate API Challenge
This repository contains  code base to implement the population estimate API challenge given by PeerStreet(https://github.com/schow6272003/peer_street_api_doc).  A Restful API is built on Node.js and a gem is created to act as Ruby client to access the API. Also, I built a demo site with React + Rails to showcase the practice application of the API.

---
##### Demo Site:
Besides zip code, CBSA code and MSA name fields can be used to query the records.
https://pstreet-app.herokuapp.com/


##### API Endpoint:
https://pstreet-api.herokuapp.com/api/cbsa?cbsa_ids[]=15540&cbsa_ids[]=11260&zip_codes[]=79607

### Stack
---
#### Server: 
   - Node.js
   - Postgres 
   - MongoDB
   - Redis

#### Ruby Client: 
  - Ruby Gem 

#### Demo Site: 
   - React.js
   - Database.js
   - Selectize.js
   - Ruby On Rails
#### Cloud Platform: 
   - Heroku *My prefer platform would be AWS Beanstalk, but Heroku was chosen instead for this project due to time constraint.


## Installation and setup on local machine

<details>
<summary>API Node Server Setup</summary>

#### 1. Install and Run PostgreSQL
Refer to Postgres documentation for setup instructions on local machine.
https://www.postgresql.org/docs/

#### 2. Install and Run MongoDB 
Refer to Postgres documentation for setup instructions on local machine.
https://docs.mongodb.com/

#### 3. Install and Run Redis 
Refer to Postgres documentation for setup instructions on local machine.
https://redis.io/documentation

#### 4. Setup and Run Node.js
- ##### Pull base code from git repository to your local machine
```
git clone https://github.com/schow6272003/ps_api
cd ps_api
```
- ##### Install Node dependencies
```
npm install
```
- ##### Create .env file
```
DB= (Postgres database name)
DB_HOST= (Postgres database host)
DB_USER= (Postgres database username)
DB_PASS= (Postgres database password)
cbsa=https://s3.amazonaws.com/peerstreet-static/engineering/zip_to_msa/zip_to_cbsa.csv
msa=https://s3.amazonaws.com/peerstreet-static/engineering/zip_to_msa/cbsa_to_msa.csv
MetStatString='Metropolitan Statistical Area'
MONGODB= (Mongodb database name)
MONGDB_COLLECTION=(Mongodb collection )
MONGODB_HOST=(Mongodb database host)
```
- ##### Setup Config.js for Sequelizer
```javascript
require('dotenv').config();
module.exports = {
  development: {
    username: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB,
    host: process.env.DB_HOST,
    dialect: "postgres",
    operatorsAliases: false
  },
  test: {
    username: 'database_test',
    password: null,
    database: 'database_test',
    host: '127.0.0.1',
    dialect: 'postgres'
  },
  production: {
    username: 'database_production',
    password: null,
    database: 'database_production',
    host: 'database_production_host',
    dialect: "postgres",
    operatorsAliases: false
  }
};
```
- ##### Setup .sequelizerc 
```javascript
const path = require('path');
module.exports = {
  'config': path.resolve('config', 'config.js')
}
```

- ##### Setup .babelrc for Babel 
```javascript
{
  "presets": [
    "@babel/preset-env"
  ]
}
```

- ##### Run migrations on Postgres with Sequelizer
```
npx sequelize db:migrate
```

- ##### Fetch CBSA data remotely to Postgres database
```
node imports/import_postgres.js
```
- ##### Import and parse CBSA data to Mongodb from Postgres
```
node imports/import_mongodb.js
```
- ##### Run Node.js Server
```
nodemon app.js
```
</details>
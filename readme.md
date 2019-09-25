# PeerStreet Population Estimate API Challenge
## About
This repository contains  code base to implement the population estimate API challenge given by PeerStreet(https://github.com/schow6272003/peer_street_api_doc).  A Restful API is built on Node.js and a gem is created to act as Ruby client to access the API. Also, I built a demo site with React + Rails to showcase the practice application of the API.

##### Demo Site:
Besides zip code, CBSA code and MSA name fields can be used to query the records.
https://pstreet-app.herokuapp.com/

##### API Endpoint
https://pstreet-api.herokuapp.com/api/cbsa?cbsa_ids[]=15540&cbsa_ids[]=11260&zip_codes[]=79607

### Stack
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
   - Heroku (My prefer platform would be AWS Beanstalk, but Heroku was chosen instead for this project due to time constraint.)



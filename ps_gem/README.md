## PeerStreet Population Estimate Ruby Client
This is gem is built as Ruby client to access to the endpoint:</br>
https://pstreet-api.herokuapp.com/api/v1/cbsa/find?cbsa_ids[]=15540&cbsa_ids[]=11260&zip_codes[]=79607

## Other Repositories:
  - [PeerStreet Challenge](https://github.com/schow6272003/peer_street_challenge)
  - [API Node Server](https://github.com/schow6272003/ps_api)
  - [Demo Site](https://github.com/schow6272003/ps_app)


## Installation
1. Rails App
#### Add the following line to Gemfile 
```
gem 'ps_pop_client'
```

#### Execute 'bundle'
```
bundle install
```
2. Cli
```
gem install 'ps_pop_client'
```

## Usage

### Send Request

##### step 1.
```ruby
 required 'ps_pop_client'
```
##### step 2.
```ruby
# request params
params = {:cbsa_ids => [11260,3232],
           :zip_codes => [79607, 90254],
           :name => "South Bay"
          }
## 1. default endpoint is "https://pstreet-api.herokuapp.com"
PSClient::Api.new.find(params)

## 2. include your own endpoint:
PSClient::Api.new({:base_uri => "https://myown-api.com"}).find(params)
```

##### Params Fields Definition
| Items  | Description | Type  | 
| :------------ |:---------------:| -----:|
| cbsa_ids      | CBSA Codes| Array | 
| zip_codes     | Zip Codes   |  Array|
| name          | MSA Name  |  String |

### Run Rspec 
```
rspec
```







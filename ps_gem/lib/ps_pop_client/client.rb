DEFAULT_URI = 'https://pstreet-api.herokuapp.com'

module PSClient
  require_relative 'tools/request_util'
  class Api < BaseApi
    def initialize(args={ :base_uri => DEFAULT_URI })
      super(args)
    end 

    def find(req={}) 
      begin
        parsed_req = parse_req_to_symbols(req)
        check_request(parsed_req)
        uri = encode_uri(parsed_req)
        response = request(uri)
        check_status(response)
        fitlered_response = filter_records(parsed_req, response)
        return Response.new(fitlered_response).parse
      rescue => e
        return Response.new(e).parse_error
      end
    end 

    private      
      def check_status(response)
        return if (200..299).cover?(response.code.to_i)
        raise Error.new(response.message, response.code)
      end
      
      def filter_records(req, response) 
        ResponseUtil.filter_records(req, response)
      end 
      
      def parse_req_to_symbols(req)
        RequestUtil.parse_to_symbol(req)
      end 
      def check_request(req)
        RequestUtil.validate_find_request(req)
      end 
      def encode_uri(req)
        cbsa_ids_uri = (req.keys.include?(:cbsa_ids) && req[:cbsa_ids].kind_of?(Array)) ? req[:cbsa_ids].inject("") { |s, a| s + "cbsa_ids[]=" + a.to_s + "&" } : ""
        zipcodes_uri = (req.keys.include?(:zip_codes) && req[:zip_codes].kind_of?(Array)) ? req[:zip_codes].inject("") { |s, a| s + "zip_codes[]=" + a.to_s + "&" } : ""
        name = (req.keys.include?(:name) && req[:name].kind_of?(String)) ? "name=" + req[:name] : ""
        "/api/v1/cbsa/find?" + cbsa_ids_uri + zipcodes_uri + name
      end 
  end
end 


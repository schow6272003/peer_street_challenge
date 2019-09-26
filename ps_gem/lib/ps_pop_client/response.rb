module PSClient
  require 'json'
    require_relative 'tools/error_util'
    require_relative 'tools/response_util'
    class Response
      def initialize(response= {})
        @response=response
      end 
      
      def parse
        res_body = JSON.parse(@response.body)
        { status: @response.code.to_i , data:res_body["data"]}
      end 

      def parse_error
         ErrorUtil.parse_response(@response);
      end 
  end
end 
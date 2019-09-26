module PSClient
  require 'net/http'
  require 'uri'

  class APIConnection
    def initialize(uri=nil,path=nil)
      @base_uri = uri
      @path = path
    end 
    
    def get
      url = get_url
      request = Net::HTTP::Get.new(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true if url.scheme == 'https'
      response = http.request(request)
      return response
    end

    private
      def get_url
        URI.parse("#{@base_uri}#{@path}")
      end 
  end 
end 
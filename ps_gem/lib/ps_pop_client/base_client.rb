
module PSClient
  class BaseApi
    def initialize(args={ :base_uri => nil })
      @base_uri  = args[:base_uri]
    end 
  
    def request(path)
      APIConnection.new(@base_uri, path).get
    end 
  end  
end
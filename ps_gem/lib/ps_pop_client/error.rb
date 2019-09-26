module PSClient 
  class Error < StandardError
    attr_reader :code
    def initialize(message = nil, code = nil)
      super(message)
      @code = (code) ? code : 500
    end
  end
end
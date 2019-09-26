require 'spec_helper'

describe PSClient::VERSION do
  it 'has ver. number' do 
    expect(PSClient::VERSION).not_to be_empty 
  end 
end
require 'spec_helper'

describe PSClient::Api do
  before do
    @client = described_class.new
  end  

  describe "#find"  do
    subject {@client.find(req)}

    context "when valid request params" do 
      let(:req) { { "cbsa_ids" => [11260] }} 
      it "expects to return with 200 status code" do
        expect(subject[:status]).to eq 200
      end 
      
      it "expects to return 1 record" do
        expect(subject[:data]["records"].count).to eq 1
      end
      
      it "expects cbsa code to be 11260" do
        expect(subject[:data]["records"][0]["cbsa_id"]).to eq 11260
      end 

      it "expects to include zipcodes" do
        expect(subject[:data]["records"][0]["zip_code"]).to include(99501,99502,99503)
      end 
      
      it "expects to include msa name" do
        expect(subject[:data]["records"][0]["name"]).to eq "Anchorage, AK"
      end

      it "expects to include 2014 pop estimate" do 
        expect(subject[:data]["records"][0]["pop_estimate"][4]["number"]).to eq 398642
      end
      it "expects to include 2015 pop estimate" do 
        expect(subject[:data]["records"][0]["pop_estimate"][5]["number"]).to eq 399790
      end
    end  

    context "when search using zipcodes" do
      let(:req) { { :zip_codes => [48813,5482] }} 
    
      it "expects to return with 200 status code" do
        expect(subject[:status]).to eq 200
      end 

      it "expects to return 2 record" do
        expect(subject[:data]["count"]).to eq 2
      end

      it "expects first record to have zipcode 48813" do
        expect(subject[:data]["records"][0]["zip_code"]).to include(48813)
      end

      it "expects first record to have zipcode 5482" do
        expect(subject[:data]["records"][1]["zip_code"]).to include(5482)
      end
    end  

    context "when search msa name by keyword" do
      let(:req) { { :name => "Burlington" }} 

      it "expects to return with 200 status code" do
        expect(subject[:status]).to eq 200
      end 

      it "expects to return 2 record" do
        expect(subject[:data].count).to eq 2
      end

      it "expects to include 'Burlington' on msa name" do
        expect(subject[:data]["records"][0]["name"]).to include("Burlington")
      end
    end 

    context "When no records are found" do
      let (:req) {{:name => "Hello World!"}}
      
      it "expects to return with 200 status code" do
        expect(subject[:status]).to eq 200
      end
      
      it "expects to return 0 records" do
        expect(subject[:data]["records"].count).to eq 0
      end 
    end

    context "when request is invalid"  do 
      let(:req) { {}}
      
      it "expect to response http status to be" do 
        expect(subject[:status]).to eq 400
      end
    end
  end 
end
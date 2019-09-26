module ResponseUtil
  def self.filter_by_zipcodes(a_for, a_against)
    return [] if !a_for.kind_of?(Array) || a_for.count == 0
    result = a_for.select do |e|
      a_against.include?(e)
    end
    return result
  end

  def self.filter_records(req,response)
    return response unless req[:zip_codes].kind_of?(Array)
    res_body = JSON.parse(response.body)
    records = res_body["data"]["records"]
      records.each do |record|
        if self.should_filter?(req[:cbsa_ids], record["cbsa_id"],record["zip_code"], req[:zip_codes]) 
          record["zip_code"] = self.filter_by_zipcodes(record["zip_code"], req[:zip_codes])
        end 
      end 
    res_body["data"]["records"] = records
    res_body["data"]["count"] = records.length
    response.body = JSON.generate(res_body)
    return response
  end  
   
  def self.should_filter?(cbsa_ids_array, cbsa_id, res_zipcodes,req_zipcodes)
    cbsa_ids = !cbsa_ids_array ? [] : cbsa_ids_array
    !(cbsa_ids.include? cbsa_id.to_i) && self.compare_zipcodes(res_zipcodes,req_zipcodes)
  end 

  def self.compare_zipcodes(a, b)
    (a&b).size  > 0 
  end
end  
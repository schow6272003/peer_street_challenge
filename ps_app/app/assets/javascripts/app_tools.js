var AppTools = {
      handleSpinner: (option) => {
        let spinner = document.getElementById("loadingSpan");
        spinner.style.display =(option == "show") ?  "block" : "none";
      },
      formatNumber: (num) => {
        if (!num) return null;
         return new Intl.NumberFormat('en-IN', { maximumSignificantDigits: 20 }).format(Number(num));
      },
      encodeUrl: (zipCodes, cbsaIds, name) => {
        let apiUrl = '/api/v1/find?';
        let zipCodeUri = zipCodes.reduce((s, i) => {
          let newString = s + "req[zip_codes][]=" + i.toString() + "&";
          return newString;
        } ,"");

        let cbsaIdsUri = cbsaIds.reduce((s, i) => {
          let newString = s + "req[cbsa_ids][]=" + i.toString() + "&";  
          return newString;
        } ,"");
    
        let msaName =  "req[name]=" + name;
        return apiUrl + zipCodeUri + cbsaIdsUri + msaName;
      },
      parseRecords (data)  {
        let records =  data.records.reduce((a, r) => {
            let sub_records = [];
            for (let i = 0 ; i < r.zip_code.length; i++) {
              sub_records.push({
                                 zip_code: r.zip_code[i],
                                 cbsa_id: r.cbsa_id,
                                 name: r.name,
                                 "2014": this.formatNumber(r.pop_estimate[4].number),
                                 "2015": this.formatNumber(r.pop_estimate[5].number)
                               });
            };

            a =  [...a, ...sub_records];
            return a;
          },[]);
        return records;
       }
    };
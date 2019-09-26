class SearchPanel extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      selectizeZipCode: null,
      selectizeCBSA: null 
    }
  }
  handleSearch(e) {     
    let zipCodes = this.state.selectizeZipCode.items;
    let cbsaIds = this.state.selectizeCBSA.items;
    let msaName = document.getElementById("msa-field").value;

    if (zipCodes.length > 0 || cbsaIds.length > 0  || msaName) {
      AppTools.handleSpinner("show");
      this.handleEmptyFieldsAlfert("hide");
      this.callApi(zipCodes, cbsaIds, msaName)
      .then((response) => {
        this.props.updateTable(response);
        AppTools.handleSpinner("hide");
      }).catch((err) => {
        AppTools.handleSpinner("hide");
        console.log(err)
      });
     }  else {
      this.handleEmptyFieldsAlfert("show");
     }
   }
   componentDidMount() {
     this.handleEmptyFieldsAlfert("hide");
     this.initiateSelectize();
   }
   handleReset()  {
     document.getElementById("msa-field").value = null;
     this.handleEmptyFieldsAlfert("hide");
     this.state.selectizeZipCode.clear();
     this.state.selectizeCBSA.clear();
     this.props.updateTable([]);
   }
   handleEmptyFieldsAlfert(option) {
     if(option =="show") {
      $("#emtpy-field-alert").show();
      $(".alert-star").show();
     } else if (option =="hide") {
      $("#emtpy-field-alert").hide();
      $(".alert-star").hide();
     }
    }
    callApi(zipCodes, cbsaIds, msaName) {
      let promise = new Promise((resolve, reject)=>{
          const url = AppTools.encodeUrl(zipCodes, cbsaIds, msaName);
            fetch(url)
            .then( (response) => {
              return response.json();
            }).then((response) => {
              if (response.status != 200) {
                throw new Error( "status: " + response.status  + ", message: " + response.message);
              } 
              let records = AppTools.parseRecords(response.data);
              resolve(records);
            }).catch((err) => {
              reject(err);
            }); 
        })
      return promise;
     }
     initiateSelectize() {
       const options = {
         delimiter: ',',
         persist: false,
         create: function(input) {
                   return {value: input,text: input
                 }
         }
       }
       const $selectZipCode = $('#zip-code-field').selectize(options);
       const $selectCBSA = $('#cbsa-id-field').selectize(options);
       this.setState({selectizeZipCode: $selectZipCode[0].selectize, selectizeCBSA: $selectCBSA[0].selectize })
     }
    render () {
      return (
               <div className="panel panel-default">
               <div className="panel-heading">Search Records</div>
               <div className="panel-body">
                 <div className="container">
                   <div className="row">
                     <div className="col-md-12">
                       <form>
                         <div className="form-row">
                           <div className="col-md-3 mb-3">
                             <label>Zip Code<span className="alert-star" >*</span></label>
                             <input id="zip-code-field" type="text" className="form-control" placeholder="Zip Code"></input> 
                           </div>
                           <div className="col-md-3 mb-3">
                             <label>CBSA Code<span className="alert-star" >*</span></label>
                             <input id="cbsa-id-field" type="text" className="form-control" placeholder="CBSA Code"></input> 
                           </div>
                           <div className="col-md-3 mb-3">
                             <label>MSA Name<span className="alert-star" >*</span></label>
                             <input id="msa-field" type="text" className="form-control" placeholder="MSA Name"></input> 
                           </div>
                           <div className="col-md-3 mb-3">
                             <div className="flex_container">
                               <button type="button" className="btn btn-primary button_container" onClick={this.handleSearch.bind(this, null)}>Search</button>
                               <button type="button" className="btn btn-danger button_container" onClick={this.handleReset.bind(this, null)}>Reset</button>
                             </div>
                           </div>
                         </div>
                       </form>
                     </div>
                   </div>
                   <div className="row">
                     <div className="col-md-9">
                       <div className="flex_container">
                         <span id="emtpy-field-alert">Fields Can Not Be All Empty!!</span>
                       </div>
                     </div>
                   </div>
                </div>
              </div>
            </div>
            );
    }
}
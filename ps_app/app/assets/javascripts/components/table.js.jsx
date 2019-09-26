class Table extends React.Component {
  constructor(props) {
    super(props) 
         this.state  = {
           title: this.props.title,
           headers: this.props.headers,
           records: [], 
           tableId: this.props.tableId
         }
  }
  componentDidMount() {
    this.initiateTable();
  }
  updateTBody(records) {
    $("#" + this.state.tableId).DataTable().destroy();
    this.setState({records: records},() => {
      this.initiateTable();
    });
  }
  initiateTable()  {
        $("#" + this.state.tableId ).dataTable();     
  }
  render () {
        return (
                <div>
                  <table id={this.state.tableId} className="table table-hover">
                    <thead>
                      <tr>
                        { 
                          this.state.headers.map((header,i) => {
                            return (<th key={i}>{header.name}</th>);
                          }, this)
                        }
                      </tr>
                    </thead>
                    <tbody id="table_body">
                     {
                      this.state.records.map((record, i) =>{
                        return (
                                 <tr key={i} >
                                  { 
                                   this.state.headers.map((header,j) => {
                                     return ( 
                                              <td key={j} width={header.width}>
                                                 {record[header.key]}
                                              </td> 
                                            );  
                                    })
                                   }
                                  </tr>
                               );
                        }, this)
                      }
                     </tbody>
                   </table>
                 </div>
               );
  }
};
class Main extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      headers: [{name:"Zip Code", key: "zip_code", width: "20%" }, {name:"CBSA Code", key: "cbsa_id", width: "20%" }, 
                            {name: "MSA Name", key: "name", width: "30%"}, {name:"Pop 2014", key: "2014", width: "15%"}, {name:"Pop 2015", key: "2015", width: "15%"} ], 
    }
  }
  render () {
    return (
             <div>
              <main className="col-md-12">
                <Search title={"Text Search"} headers={this.state.headers} />
              </main>
             </div>
           );
  }
}
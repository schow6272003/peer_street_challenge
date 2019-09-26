class Search extends React.Component {
  constructor(props) {
    super(props)
    this.searchTable= React.createRef();
    this.state  = {
      title: this.props.title, 
      headers: this.props.headers
    }
  }
  updateTable(records) {
    this.searchTable.current.updateTBody(records);
  }
  render () {
    return (
             <div>
               <SearchPanel  updateTable={this.updateTable.bind(this)} />
               <Table ref={this.searchTable}  tableId="search-table" headers={this.state.headers} />
             </div>
           );
  }
};
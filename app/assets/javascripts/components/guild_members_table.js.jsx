var GuildMembersTable = React.createClass({
  propTypes: {
    members: React.PropTypes.array.isRequired
  },

  getInitialState() {
    return({
      resyncClicked: false
    })
  },

  ilevelRank(i) {
    return(i < 5 ? 'legendary' : i < 15 ? 'epic' : 'rare')
  },

  tableRows() {
    rows = []
    this.props.members.forEach(function(member, i) {
      rows.push(
        <tr key={i}>
          <td>{i+1}</td>
          <td>{member.name}</td>
          <td className={this.ilevelRank(i)}>{member.equipped_ilevel}</td>
          <td>{member.max_ilevel}</td>
          <td className={member.character_class.toLowerCase()}>
            <img className='character_class-icon' src={member.character_class.toLowerCase()+'.png'}/>
            <span>{member.character_class}</span>
          </td>
          <td>{member.specialization}</td>
          <td>{member.role}</td>
        </tr>
      )
    }.bind(this))
    return rows
  },

  onResync() {
    this.setState({
      resyncClicked: true
    })
  },

  resyncButtonText() {
    if (this.state.resyncClicked) {
      return("👌 Update job started")
    } else {
      return("Begin member update job")
    }
  },

  render() {
    return (
      <div>
        <div className="update-section">
          <img className='guild-crest' src='crest.png'/>
          <h1 className='guild-name'>Obsidian Sky</h1>
        </div>
        <table>
          <tbody>{this.tableRows()}</tbody>
        </table>
        <div className="update-section">
          <button src='/members/resync' onClick={this.onResync.bind(this)} className='button button__member-update'>{this.resyncButtonText()}</button>
          <div className="last-updated">Last updated {this.props.members[0].updated_at}</div>
        </div>
      </div>
    )
  }
})

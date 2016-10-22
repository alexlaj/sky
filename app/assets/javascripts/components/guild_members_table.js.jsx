var GuildMembersTable = React.createClass({
  propTypes: {
    members: React.PropTypes.array.isRequired
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

  render() {
    return (
      <div>
        <h1 className='guild-name'>Obsidian Sky</h1>
        <table>
          <tbody>{this.tableRows()}</tbody>
        </table>
        <div className="update-section">
          <button src='/members/resync' className='button button__member-update'>Begin member update job</button>
          <div className="last-updated">Last updated ago.</div>
        </div>
      </div>
    )
  }
})

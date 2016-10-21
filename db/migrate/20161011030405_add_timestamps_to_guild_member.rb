class AddTimestampsToGuildMember < ActiveRecord::Migration[5.0]
  def change
    add_column :guild_members, :created_at, :datetime
    add_column :guild_members, :updated_at, :datetime
  end
end

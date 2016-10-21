class CreateGuildMember < ActiveRecord::Migration
  def change
    create_table :guild_members do |t|
      t.string :name
      t.integer :level
      t.string :class
      t.integer :max_ilevel
      t.integer :equipped_ilevel
      t.string :specialization
      t.string :role
    end
  end
end

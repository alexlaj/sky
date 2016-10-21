class RenameCharactersClassColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :guild_members, :class, :character_class
  end
end

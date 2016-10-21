class MemberUpdater
  CLASSES = %w(NA Warrior Paladin Hunter Rogue Priest Deathknight Shaman Mage
               Warlock Monk Druid Demonhunter).freeze

  def self.retrieve_members
    bnet = BattlenetClient.new(ENV['BATTLENET'])
    members = bnet.get_guild('Lightbringer', 'Obsidian Sky')['members']
    members = members.select { |m| m['character']['level'] == 110 }
    a = []
    members.each do |member|
      a << bnet.get_character('Lightbringer', member['character']['name'])
    end
    a
  end

  def self.run(members)
    classes = %w(NA Warrior Paladin Hunter Rogue Priest Deathknight Shaman Mage
                 Warlock Monk Druid Demonhunter)
    ActiveRecord::Base.transaction do
      members.each do |member|
        next if member['status'] == 'nok'
        m = GuildMember.find_or_create_by(name: member['name'])
        m.update(
          level: member['level'],
          character_class: CLASSES[member['class']],
          max_ilevel: member['items']['averageItemLevel'],
          equipped_ilevel: member['items']['averageItemLevelEquipped'],
          specialization: member['talents'][0]['spec']['name'],
          role: member['talents'][0]['spec']['role']
        )
      end
    end
  end

  def self.update_members(members)
    bnet = BattlenetClient.new(ENV['BATTLENET'])
    updated_members = []
    members.each do |member|
      updated_members << bnet.get_character('Lightbringer', member.name)
    end

    ActiveRecord::Base.transaction do
      updated_members.each do |member|
        next if member['status'] == 'nok'
        m = GuildMember.find_or_create_by(name: member['name'])
        m.update(
          level: member['level'],
          character_class: CLASSES[member['class']],
          max_ilevel: member['items']['averageItemLevel'],
          equipped_ilevel: member['items']['averageItemLevelEquipped'],
          specialization: member['talents'][0]['spec']['name'],
          role: member['talents'][0]['spec']['role']
        )
      end
    end
  end
end

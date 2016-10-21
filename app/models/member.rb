require 'yaml'

class Member
  def self.members
    members = JSON.parse(File.read('config/members.json'))['members']
    members = members.select { |m| m['character']['level'] == 110 }
    members.sort_by do |m|
      [m['character']['name'], m['character']['class']]
    end
  end

  def self.members_with_ilevel
    members = JSON.parse(File.read('config/members_with_item.json'))
    members.sort { |a, b| b['items']['averageItemLevelEquipped'] <=> a['items']['averageItemLevelEquipped'] }
  end

  def self.insert
    @classes = %w(
      NA Warrior Paladin Hunter Rogue Priest Deathknight Shaman Mage Warlock
      Monk Druid Demonhunter
    )
    ActiveRecord::Base.transaction do
      members_with_ilevel.each do |member|
        GuildMember.new(
          name: member['name'],
          level: member['level'],
          character_class: @classes[member['class']],
          max_ilevel: member['items']['averageItemLevel'],
          equipped_ilevel: member['items']['averageItemLevelEquipped'],
          specialization: member['talents'][0]['spec']['name'],
          role: member['talents'][0]['spec']['role']
        ).save
      end
    end
  end

  def self.refresh_members_with_ilevel
    bnet = BattlenetClient.new(YAML.load_file('config/secrets.yml')['battlenet'])
    a = []
    members.each do |member|
      a << bnet.get_character('Lightbringer', member['character']['name'])
    end
    File.open('config/members_with_item.json', 'wb') do |f|
      f.write('[')
      f.write(a.join(','))
      f.write(']')
    end
  end
end

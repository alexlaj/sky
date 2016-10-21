require 'json'

class MembersController < ApplicationController
  def index
    load_guild_members
    render
  end

  def resync
    load_guild_members
    Delayed::Job.enqueue(MemberUpdateJob.new(@members))

    redirect_to members_url
  end

  private

  def load_guild_members
    @members = GuildMember.where(level: 110)
                          .order('equipped_ilevel desc')
                          .limit(50)
  end
end

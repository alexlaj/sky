require 'json'

class GuildMembersController < ApplicationController
  def index
    load_guild_members
    respond_to do |format|
      format.html { render component: 'GuildMembersTable', props: { members: @members } }
      format.json { render json: @members }
    end
  end

  def resync
    load_guild_members
    Delayed::Job.enqueue(MemberUpdateJob.new)

    redirect_to root_url
  end

  private

  def load_guild_members
    @members = GuildMember.where(level: 110)
                          .order('equipped_ilevel desc, max_ilevel desc')
  end
end

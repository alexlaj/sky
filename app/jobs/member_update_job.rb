class MemberUpdateJob
  def initialize(members)
    @members = members
  end

  def perform
    MemberUpdater.update_members(@members)
  end
end

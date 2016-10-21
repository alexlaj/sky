class MemberUpdateJob
  def perform
    MemberUpdater.run(MemberUpdater.retrieve_members)
  end
end

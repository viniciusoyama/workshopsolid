# Solution

class FacebookInviter

  def initializer(user, party, app_id)
    super(user, party)
    @app_id = app_id
  end
end

class InviterCreatorWorker
  def perform
    @invites_data.each do |invite_data|
      inviter = build_inviter(invite_data)
      inviter.invite
    end
  end

  def build_inviter(invite_data)
    if invite_data.type.email?
      EmailInviter.new(invite_data.user, invite_data.party)
    elsif invite_data.type.facebook?
      FacebookInviter.new(invite_data.user, invite_data.party, 123123)
    else
      Inviter.new(invite_data.user, invite_data.party)
    end
  end
end


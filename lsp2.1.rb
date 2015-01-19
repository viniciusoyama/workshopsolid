# now we have a facebook inviter

class FacebookInviter < Inviter 
  def invite(facebook_app_token)
    super
    #post to FACEBOOK
  end
end

class InviterCreatorWorker
  def perform
    @invites_data.each do |invite_data|
      inviter = build_inviter(invite_data)
      if invite_data.type.facebook?
        inviter.invite(123123)
      else
        inviter.invite
      end
    end
  end

  def build_inviter(invite_data)
    if invite_data.type.email?
      EmailInviter.new(invite_data.user, invite_data.party)
    elsif invite_data.type.facebook?
      FacebookInviter.new(invite_data.user, invite_data.party)
    else
      Inviter.new(invite_data.user, invite_data.party)
    end
  end
end

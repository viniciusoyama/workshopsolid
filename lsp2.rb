# Users
# Parties
# User can be invitedd to parties

class Inviter
  def initializer(user, party)
    @user = user 
    @party
  end

  def invite
    Invitation.create(user: @user, party: @party)
  end
end


class EmailInviter < Inviter 
  def invite
    super
    InvitationMailer.invite(@user, @party).deliver
  end
end

# Worker in background process a list of invitations
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
    else
      Inviter.new(invite_data.user, invite_data.party)
    end
  end
end

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


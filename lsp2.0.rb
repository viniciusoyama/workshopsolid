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

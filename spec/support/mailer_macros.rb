module MailerMacros
  def reset_email
    ActionMailer::Base.deliveries = []
  end
end

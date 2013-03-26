module AuthMacros
  def log_in(role, attributes = {})
    @_current_user = Cavy::User.create(email: 'user@mail.com', password: 'secret', password_confirmation: 'secret', role: role)
    visit '/admin/signin'
    fill_in "user-email", with: @_current_user.email
    fill_in "user-password", with: @_current_user.password
    click_button "sign-in"
  end

  def log_out
    Capybara.reset_sessions!
  end

  def current_user
    @_current_user
  end
end
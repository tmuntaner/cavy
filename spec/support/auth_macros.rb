module AuthMacros
  def log_in(role)
    @_current_user = FactoryGirl.create(:cavy_user, role: role)
    visit admin_signin_path(locale: :en)
    fill_in 'user-email', with: @_current_user.email
    fill_in 'user-password', with: @_current_user.password
    click_button 'sign-in'
  end

  def log_in_rack(role)
    user_data = { password: 'secret', password_confirmation: 'secret',
                  role: role }
    @user = create(:cavy_user, user_data)
    @session = { email: @user.email, password: 'secret' }
    post admin_create_session_path(locale: :en), params: @session
  end

  def log_out
    Capybara.reset_sessions!
  end

  def current_user
    @_current_user
  end
end

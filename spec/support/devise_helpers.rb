module DeviseSupport
  module SessionHelpers

    # traditional/actual sign in helper for
    # login page since it has been customised
    def sign_in_with(email, password, vault_key="novaultkey")
      visit new_member_session_path

      fill_in "member_email", with: email
      fill_in "member_password", with: password

      click_button "Log in"
    end

    def sign_out_of
      visit destroy_user_session_path
    end
  end
end

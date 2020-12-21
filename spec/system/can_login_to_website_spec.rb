require "rails_helper"

RSpec.describe "Log in", type: :system do

  let(:member) { create(:member) }

  context "with unsuccessfull attempts" do
    it "member cannot sign in if not registered" do
      sign_in_with("no@home.com", "any!password1")
      expect(page).to have_content I18n.t "devise.failure.not_found_in_database", authentication_keys: "Email"
    end

    it "member cannot sign in with wrong email" do
      sign_in_with("someoneelse@example.com", member.password)
      expect(page).to have_content I18n.t "devise.failure.not_found_in_database", authentication_keys: "Email"
    end

    it "member cannot sign in with wrong password" do
      sign_in_with(member.email, "invalidpass")
      expect(page).to have_content I18n.t "devise.failure.invalid", authentication_keys: "Email"
    end
  end

  context "with successful attempts" do
    it "member can sign in with valid credentials" do
      sign_in_with(member.email, member.password)
      expect(page).to have_content I18n.t "devise.sessions.signed_in"
    end
  end
end

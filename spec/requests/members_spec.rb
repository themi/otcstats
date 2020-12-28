 require 'rails_helper'

RSpec.describe "/admin//members", type: :request do

  let(:org) { create(:organisation) }
  let(:member) { create(:member) }
  before { sign_in member }

  let(:valid_attributes) {
    { full_name: "JOE", email: "email@example.com", password: "verysecretpw", password_confirmation: "verysecretpw", organisation_id: org.id }
  }

  let(:invalid_attributes) {
    { email: nil, password: nil, password_confirmation: nil, organisation_id: nil }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Member.create! valid_attributes
      get admin_members_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      member = Member.create! valid_attributes
      get admin_member_url(member)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_member_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      member = Member.create! valid_attributes
      get edit_admin_member_url(member)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Member" do
        expect {
          post admin_members_url, params: { member: valid_attributes }
        }.to change(Member, :count).by(1)
      end

      it "redirects to the created member" do
        post admin_members_url, params: { member: valid_attributes }
        expect(response).to redirect_to(admin_member_url(Member.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Member" do
        expect {
          post admin_members_url, params: { member: invalid_attributes }
        }.to change(Member, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_members_url, params: { member: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { full_name: "NEW_NAME" }
      }

      it "updates the requested member" do
        member = Member.create! valid_attributes
        patch admin_member_url(member), params: { member: new_attributes }
        member.reload
        expect(member.full_name).to eq "NEW_NAME"
      end

      it "redirects to the member" do
        member = Member.create! valid_attributes
        patch admin_member_url(member), params: { member: new_attributes }
        member.reload
        expect(response).to redirect_to(admin_member_url(member))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        member = Member.create! valid_attributes
        patch admin_member_url(member), params: { member: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested member" do
      member = Member.create! valid_attributes
      expect {
        delete admin_member_url(member)
      }.to change(Member, :count).by(-1)
    end

    it "redirects to the members list" do
      member = Member.create! valid_attributes
      delete admin_member_url(member)
      expect(response).to redirect_to(admin_members_url)
    end
  end
end

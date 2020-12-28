require "rails_helper"

# !! added specs to cover the missing gaps, I guess these are candidates for removal?

RSpec.describe ApplicationHelper do

  describe "#table_action_buttons" do
    subject(:helper_method) { helper.table_action_buttons(record, vars, actions, commands) }

    let!(:record) { create(:statistic) }
    let(:vars)    { [] }
    let(:actions) { [] }

    context "with the show command (only)" do

      let(:commands)  { "s" }

      it "returns the button to show record" do
        expect(helper_method).to have_selector ".button_to[action='/statistics/#{record.id}']"
      end
    end
  end

  describe "#notice_alert_color" do
    subject(:helper_method) { helper.notice_alert_color(type) }

    context "with type = notice" do
      let(:type)  { :notice }
      it "returns success" do
        expect(helper_method).to eq "success"
      end
    end

    context "with type = alert" do
      let(:type)  { :alert }
      it "returns danger" do
        expect(helper_method).to eq "danger"
      end
    end

  end


end

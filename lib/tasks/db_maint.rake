require "yaml"
require "csv"
require "securerandom"

namespace :dbmaint do
    desc "Load OTC Graphs"
    task load_graphs: :environment do
      data = Rails.application.config_for(:otc_graphs)
      data[:otc_graphs].each do |row|
        org = Organisation.find_or_create_by(name: row[:organisation])
        Graph.find_or_create_by(organisation: org, name: row[:name]) do |r|
          r.item_number = row[:item_number]
          r.name = row[:name]
          r.active_state = row[:active_state]
          r.short_name = row[:short_name]
          r.defintion = row[:defintion]
          r.value_title = row[:value_title]
          r.field_titles = row[:field_titles] if row[:field_titles]
        end
      end
    end

    desc "Load OTC Members"
    task load_members: :environment do
      csv_file = Rails.root.join("config", "members.csv")
      CSV.foreach(csv_file, headers: true) do |row|
        org = Organisation.find_or_create_by(name: row["organisation"])
        Member.find_or_create_by(organisation: org, full_name: row["full_name"]) do |r|
          r.organisation = org
          r.full_name = row["full_name"]
          r.role = row["role"]
          r.email = row["email"]
          r.address = row["address"]
          r.phone = row["phone"]
          r.training_level = row["training_level"]
          r.processing_level = row["processing_level"]

          pass = SecureRandom.base64(12)
          r.password = pass
          r.password_confirmation = pass
          puts "Email: #{r.email.inspect}, Password: #{pass.inspect}"
        end
      end
    end
end

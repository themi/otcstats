json.extract! member, :id, :organisation_id, :role, :full_name, :phone, :address, :training_level, :processing_level, :envisage_key, :created_at, :updated_at
json.url admin_member_url(member, format: :json)

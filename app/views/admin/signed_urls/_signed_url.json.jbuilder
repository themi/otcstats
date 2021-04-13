json.extract! signed_url, :id, :email, :token, :stream_id, :expires_in, :short_path, :used_at, :created_at, :updated_at
json.url admin_signed_url_url(signed_url, format: :json)

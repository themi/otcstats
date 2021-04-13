class CreateSignedUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :signed_urls do |t|
      t.string :email
      t.string :token
      t.string :stream_id
      t.integer :expires_in
      t.string :short_path
      t.datetime :used_at

      t.timestamps
    end
  end
end

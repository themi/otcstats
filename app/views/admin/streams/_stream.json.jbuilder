json.extract! stream, :id, :title, :description, :video_id, :signed_token, :short_url_key, :width, :height, :max_width
json.url admin_stream_url(@stream, format: :json)

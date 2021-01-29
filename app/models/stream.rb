class Stream
  class << self
    attr_accessor :streams
    def find(id)
      @streams ||= load_from_file[:streams]
      found = streams.detect { |s| s[:video_id] == id }
      found.nil? ? nil : Stream.new(found)
    end

    def find_by(attrib_name, attrib_value)
      @streams ||= load_from_file[:streams]
      found = streams.detect { |s| s[attrib_name.to_sym] == attrib_value }
      found.nil? ? nil : Stream.new(found)
    end

    private

    def load_from_file
      file_path = Rails.root.join("config", "streams.yml")
      if File.exist?(file_path)
        YAML.load_file(file_path)
      end
    end
  end

  attr_accessor :title, :video_id, :signed_token, :short_url_key, :nbf, :exp

  def initialize(data_hash)
    data_hash.each do |key, value|
      send("#{key}=", value)
    end
  end

end

class Stream
  include ActiveModel::Model
  extend ActiveModel::Naming

  class << self
    def select_list
      load_from_file[:streams].map { |stream| [stream[:title], stream[:short_url_key]] }
    end

    def all
      streams = load_from_file[:streams].map { |stream| self.new(stream) }
    end

    def find(id)
      streams = load_from_file[:streams]
      max = streams.map { |s| s[:width] }.max
      found = streams.detect { |s| s[:short_url_key] == id }
      found.nil? ? nil : Stream.new(found.merge(max_width: max))
    end

    private

    def load_from_file
      file_path = Rails.root.join("config", "streams.yml")
      if File.exist?(file_path)
        YAML.load_file(file_path)
      end
    end
  end

  attr_accessor :title, :description, :video_id, :signed_token, :short_url_key, :width, :height, :max_width

  def ratio
    (self.height.to_f / self.width.to_f * 100)
  end

  def display_width
    (self.width.to_f / self.max_width.to_f * 100)
  end

end

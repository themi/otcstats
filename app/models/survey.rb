class Survey
  include ActiveModel::Model
  extend ActiveModel::Naming

  class << self

    def find(id)
      surveys = load_from_file[:surveys]
      found = surveys.detect { |s| id.include?(s[:id]) }
      found.nil? ? nil : Survey.new(found)
    end

    private

    def load_from_file
      file_path = Rails.root.join("config", "surveys.yml")
      if File.exist?(file_path)
        YAML.load_file(file_path)
      end
    end
  end

  attr_accessor :id, :name, :email, :question1, :question2, :question3, :question4, :question5, :question6, :question7, :question8
  attr_accessor :label_name, :label_email, :label_1, :label_2, :label_3, :label_4, :label_5, :label_6, :label_7, :label_8, :checkit
end

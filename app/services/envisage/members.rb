module Envisage
  class Members < Base

    def initialize(organisation_token)
      @params = { organisation_id: organisation_token }
    end

    private

    def resource_path
      "/members"
    end

  end
end

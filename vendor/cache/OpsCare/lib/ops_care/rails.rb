module OpsCare
  # OpsCare Railtie for applying environment variables

  # Rails applications
  class Railtie < Rails::Railtie
    # Public: Apply envvars from AWS Parameter Store
    #
    # This will get called during the `before_configuration` callback, but you
    # can manually call `OpsCare::Railtie.apply_envvars` if you needed it sooner.
    def apply_envvars
      unless AwsUtils.this_instance_id.nil?
        OpsCare::Envvars.new.all.each do |env|
          ENV.store(env[:name], env[:value])
        end
        puts "[OpsCare]: Applied envvars from AWS Parameter store!"
      else
        puts "[OpsCare]: Failed to apply envvars from Parameter store - Not an EC2 Instance!"
      end
    end

    config.before_configuration { apply_envvars }
  end
end

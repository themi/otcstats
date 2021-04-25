require 'aws-sdk-ssm'

module OpsCare
  class Envvars < AwsUtils

    def all
      options = {
        path: envvar_key_prefix,
        with_decryption: true,
        recursive: true,
      }
      params = aws_client.get_parameters_by_path(options).parameters
      params.map do |param|
        {
          name: strip_key_prefix(param.name),
          value: param.value,
        }
      end
    end

    private

    def aws_client_class
      Aws::SSM::Client
    end

    def strip_key_prefix(id)
      id.split("/").last
    end

    def envvar_key_prefix
      "/envvars/#{ENV.fetch('RAILS_ENV', 'production')}/"
    end

  end
end

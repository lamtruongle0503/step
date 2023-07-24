#config/initializers/aws.rb
Aws.config[:credentials] = Aws::Credentials.new(ENV["AWS_ACCESS_KEY"], ENV["AWS_SECRET_KEY"])
Aws.config[:region] = ENV["AWS_REGION"]

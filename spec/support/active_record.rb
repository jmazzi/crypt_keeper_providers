require 'active_record'
require 'logger'
require 'yaml'

module CryptKeeperProviders
  module ActiveRecord
    # extend self

    def use_postgres
      before :all do
        config = YAML.load_file SPEC_ROOT.join('database.yml')
        ::ActiveRecord::Base.establish_connection(config['postgres'])
        ::ActiveRecord::Base.logger = Logger.new SPEC_ROOT.join('debug.log').to_s
      end
    end

    def use_mysql
      before :all do
        config = YAML.load_file SPEC_ROOT.join('database.yml')
        ::ActiveRecord::Base.establish_connection(config['mysql'])
        ::ActiveRecord::Base.logger = Logger.new SPEC_ROOT.join('debug.log').to_s
      end
    end
  end
end


RSpec.configure do |config|
  config.extend CryptKeeperProviders::ActiveRecord
end

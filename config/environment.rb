ENV['SINATRA_ENV'] ||= "development"
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])


ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)

configure :development do
    set :database, 'sqlite3:db/database.db'
end 

require_all 'app'
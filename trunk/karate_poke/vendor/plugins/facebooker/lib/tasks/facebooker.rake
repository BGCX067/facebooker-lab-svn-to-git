require 'fileutils'

namespace :facebooker do

  desc "Create a basic facebooker.yml configuration file"
  task :setup => :environment do   
    facebook_config = File.join(RAILS_ROOT,"config","facebooker.yml")
    unless File.exist?(facebook_config)
      FileUtils.cp File.join(RAILS_ROOT,"facebooker.yml.tpl"), facebook_config 
      puts "Configuration created in #{RAILS_ROOT}/config/facebooker.yml"
    else
      puts "#{RAILS_ROOT}/config/facebooker.yml already exists"
    end
  end 
        
end
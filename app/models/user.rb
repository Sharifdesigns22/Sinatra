class User < ActiveRecord::Base
    has_secure_password
    has_many :attendance
  
  
    def slug
      self.username.gsub(" ", "-").gsub(/[^\w\-]/,"").downcase
    end
  
  
    def self.find_by_slug(slug)
      self.all.find{|s| s.slug == slug} 
    end
  
  end
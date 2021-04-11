class Attendance < ActiveRecord::Base
    has_many :user
  
    def slug
      self.username.gsub(" ", "-").gsub(/[^\w\-]/,"").downcase
    end
  
  
    def self.find_by_slug(slug)
      self.all.find{|s| s.slug == slug} 
    end
  
end
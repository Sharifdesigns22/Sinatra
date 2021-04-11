class Helpers < ApplicationController


    def self.is_logged_in?(session)
        !!session[:user_id]
    end

    def self.current_user(user)
        @user= User.find(id: user[:user_id])
    end

end 
class UsersController < ApplicationController


    get '/users/:slug' do
        if Helpers.is_logged_in?(session)
            @user = User.all.find_by_slug(params[:slug])
            erb :'/users/show'
        else
            redirect '/login'
        end
    end



end

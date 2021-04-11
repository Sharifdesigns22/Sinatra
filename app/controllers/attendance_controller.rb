class AttendanceController < ApplicationController

    get '/attendance' do
        if Helpers.is_logged_in?(session)
            @user = User.find_by(id: session[:user_id])
            erb :'/attendance/attendance'
        else
            redirect '/login'
        end
    end

    get '/attendance/new' do
        if Helpers.is_logged_in?(session)
            erb :'/attendance/new'
        else
            redirect '/login'
        end
    end
    
    post '/attendance' do 
        if params[:content] != "" && Helpers.is_logged_in?(session)
            @attendance = Attendance.create(:content => params[:content])
            @attendance.save
            redirect "/attendance"
        else
            redirect "/attendance/new"
        end

    end

    get '/attendance/:id' do
        if Helpers.is_logged_in?(session)
            @attendance = Attendance.find(params[:id])
            erb :'/attendance/show_attendance'
        else
            redirect '/login'
        end
    end

    delete '/attendance/:id/delete' do
        @attendance= Attendance.find(params[:id])
        if Helpers.is_logged_in?(session)
            # @attendance.user.id == session[:user_id]
            @attendance.delete
            redirect '/attendance'
        else
            redirect '/login'
        end
    end

    get '/attendance/:id/edit' do
        if Helpers.is_logged_in?(session) == false
            redirect '/login'
        else
            @attendance = Attendance.find(params[:id])
            erb :'/attendance/edit_attendance'
        end

    end

    patch '/attendance/:id/edit' do
        if Helpers.is_logged_in?(session)
            @attendance = Attendance.find(params[:id])
        end
        if params[:updated_content] != ""
            @attendance.content = params[:updated_content]
            @attendance.save
        end
        redirect "/attendance/#{@attendance.id}/edit"
    end
end

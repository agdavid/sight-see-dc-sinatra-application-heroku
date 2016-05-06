class UsersController < ApplicationController

  ######## SIGNUP ########
  get '/signup' do
    if logged_in
      redirect '/'
    else
      erb :"users/signup", :layout => :"layout/external"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == "" 
      erb :"users/signup", :layout => :"layout/external", locals: {message: "MISSING INFORMATION! Please fill in all fields."} 
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/'
    end
  end

######## LOGIN/LOGOUT ########
  get '/login' do
    if logged_in
      redirect '/'
    else
      erb :"users/login", :layout => :"layout/external"
    end
  end

  post '/login' do
    if params[:username] == "" || params[:password] == ""
      erb :"users/login", :layout => :"layout/external", locals: {message: "MISSING INFORMATION! Please fill in all fields."}
    else
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/"
      else
        erb :"users/login", :layout => :"layout/external", locals: {message: "INVALID INFORMATION! Please try again."}
      end
    end
  end

  get '/logout' do
    if logged_in
      session.clear
      redirect "/"
    else
      redirect "/"
    end
  end

  ######## USER-LIST ########
  get '/users/:slug' do #render user show page of list and comments
    @user = User.find_by_slug(params[:slug])
    @sights = @user.sights
    @reviews = @user.reviews
    erb :"users/show", :layout => :"layout/internal"
  end

  get '/lists/new' do #render new list form
    if !current_user.sight_ids.empty?
      @user = current_user
      @sights = @user.sights
      @reviews = @user.reviews
      erb :"users/show", :layout => :"layout/internal", locals: {message: "You already have a list! View or edit your list below."}
    else
      @sights = Sight.all
      erb :"lists/new", :layout => :"layout/internal"
    end
  end 

  post '/lists' do #process new list form
    if params[:sight][:name]== "" && params[:sight][:description]== ""
      #if no new sight is added
      current_user.sight_ids = params[:user][:sight_ids]
      current_user.save
      @user = current_user
      @sights = @user.sights
      @reviews = @user.reviews
      erb :"users/show", :layout => :"layout/internal", locals: {message: "List successfully created!"}
    else
      #if a new sight field is filled
      current_user.sight_ids = params[:user][:sight_ids]
      if params[:sight][:name]== "" || params[:sight][:description]== ""
        @sights = Sight.all
        erb :"lists/new", locals: {message: "Missing new sight information! Please fill in all fields."} 
      else
        @sight = Sight.create(params[:sight])
        current_user.sights << @sight if !current_user.sights.include?(@sight)
        current_user.save
        @user = current_user
        @sights = @user.sights
        @reviews = @user.reviews
        erb :"users/show", :layout => :"layout/internal", locals: {message: "List successfully created!"}
      end
    end
  end

  get '/lists/:slug/edit' do #render edit list form, if current_user owns the list
    @user = User.find_by_slug(params[:slug])
    if @user.slug == current_user.slug
      @sights = Sight.all
      erb :"lists/edit", :layout => :"layout/internal"
    else
      erb :"users/#{@user.slug}", locals: {message: "Not authorized to edit this list!"}
    end 
  end

  patch '/lists/:slug' do #process edit list form, if current_user owns the list
    @user = User.find_by_slug(params[:slug])
    if @user.slug == current_user.slug
      @user.sight_ids = params[:user][:sight_ids]
      if params[:sight][:name]== "" || params[:sight][:description]== ""
        @sights = Sight.all
        erb :"lists/edit", locals: {message: "Missing new Sight information! Please fill in all fields"} 
      else
        @sight = Sight.create(params[:sight])
        @user.sights << @sight if !@user.sights.include?(@sight)
      end
      current_user.save
      redirect "users/#{@user.slug}"
    else
      redirect '/'
    end
  end 

end
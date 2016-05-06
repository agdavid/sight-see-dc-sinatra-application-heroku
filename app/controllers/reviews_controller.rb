class ReviewsController < ApplicationController

  get '/reviews' do #show all reviews, descending from most recent
    if logged_in
      @reviews = Review.all.order("id DESC")
      erb :"reviews/index", :layout => :"layout/internal"
    else
      redirect "/"
    end
  end

  get '/reviews/new' do #load new review form
    if logged_in
      @sights = Sight.all
      erb :"reviews/new", :layout => :"layout/internal"
    else
      redirect "/"
    end
  end

  post '/reviews' do #process new review form
    if logged_in
      @review = Review.new(content: params[:review][:content], user_id: current_user.id, sight_id: params[:sight][:id].to_i)
      @review.save
        
      current_user.reviews << @review if !current_user.reviews.include?(@review)
      current_user.save
        
      @sight = Sight.find_by_id(params[:sight][:id])
      @sight.reviews << @review if !@sight.reviews.include?(@review)
      @sight.save
      redirect "/reviews/#{@review.id}"
    else
      redirect "/"
    end
  end

  patch '/reviews/:id' do #process review edit form, if current_user owns the review
    @review = Review.find(params[:id])
    if @review.user_id == current_user.id
      @review.content = params[:review][:content]
      @review.save
      @user = User.find(@review.user_id)
      @sight = Sight.find_by_id(@review.sight_id)
      erb :"/reviews/show", :layout => :"layout/internal", locals: {message: "Review successfully updated!"}
    else
      @user = User.find(@review.user_id)
      @sight = Sight.find_by_id(@review.sight_id)
      erb :"/reviews/show", :layout => :"layout/internal", locals: {message: "#{current_user.username} this is not your review! You may not edit this content."}
    end
  end

  get '/reviews/:id' do #show single review
    if logged_in
      @review = Review.find(params[:id])
      @user = User.find(@review.user_id)
      @sight = Sight.find_by_id(@review.sight_id)
      erb :"reviews/show", :layout => :"layout/internal"
    else
      redirect '/'
    end
  end

  get '/reviews/:id/edit' do #load review edit form, if current_user owns the review
    @review = Review.find(params[:id])
    if @review.user_id == current_user.id
      @sight = Sight.find_by_id(@review.sight_id)
      @sights = Sight.all
      erb :"/reviews/edit", :layout => :"layout/internal" 
    else
      @user = User.find(@review.user_id)
      @sight = Sight.find_by_id(@review.sight_id)
      erb :"/reviews/show", :layout => :"layout/internal", locals: {message: "#{current_user.username} this is not your review! You may not edit this content."}
    end
  end 

  delete '/reviews/:id/delete' do
    @review = Review.find(params[:id])
    if @review.user_id == current_user.id
      @review.destroy
      @user = User.find(@review.user_id)
      @sights = @user.sights
      @reviews = @user.reviews
      erb :"/users/show", :layout => :"layout/internal", locals: {message: "Review successfully deleted!"}  
    else
      @user = User.find(@review.user_id)
      @sight = Sight.find_by_id(@review.sight_id)
      erb :"/reviews/show", :layout => :"layout/internal", locals: {message: "#{current_user.username} this is not your review! You may not delete this content."}
    end
  end

end
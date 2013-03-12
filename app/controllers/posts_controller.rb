class PostsController < ApplicationController

  # Lists all posts. Called when a GET request is sent to `/posts`
  def index
    # `includes` tells Rails what associations we're going to be using in
    # our view. This is important, since normally when you call `.comments`
    # on a post, Rails will make a call to the database. If you have a large
    # number of posts, this can cause a huge number of DB requests.
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts.includes(:comments)
    else
      @posts = Post.includes(:comments).all
    end
  end

  # Shows a form for creating a new post. Called when a GET request is sent to `/posts/new`
  def new
    @post = Post.new
  end


  # Create a new post. Called when a POST request is sent to `/posts`
  def create
    # Remember, params stores everything sent to the server through form or
    # querystring data. By default, `form_for` will place your data in `params[:model_name]`
    @post = Post.new(params[:post])

    # This idiom is very common in create and update actions. `save` will return
    # false if the record is invalid. We render `new` rather than redirecting so
    # that the model state, errors and all, remains intact.
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

end

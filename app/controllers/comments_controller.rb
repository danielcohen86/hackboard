class CommentsController < ApplicationController

  # Comments are nested within posts, so this will be called when
  # a user calls /posts/1/comments with the POST verb.
  def create
    # Find our parent model by id. With nested resources, the 'parent'
    # associations are always referenced by `model_id`.
    post = Post.find(params[:post_id])

    # Use the association to create the comment. This is useful since we
    # don't want to allow people to directly access the post_id on a comment.
    @comment = post.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

end

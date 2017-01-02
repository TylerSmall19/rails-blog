class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc )
  end

  def create
    post = Post.new(post_params)
    if post.save
      redirect_to '/'
    else
      @posts = Post.all.order(created_at: :desc )
      @errors = post.errors.full_messages
      render 'index'
    end
  end

  def destroy
    Post.find_by(id: params[:id]).destroy
    redirect_to '/'
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render 'update'
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post && @post.update(post_params)
      render partial: 'post', locals: { post: @post }
    end
    @errors = @post.errors.full_messages
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end

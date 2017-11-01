class PostsController < ApplicationController
  before_action :require_login, except: :show
  before_action :require_author, only: %i(edit update)

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @post.author_id = current_user.id

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def require_author
    unless Post.find(params[:id]).author == current_user
      flash[:errors] = "You must be the author to make changes"
      redirect_to post_url(@post)
    end
  end
end

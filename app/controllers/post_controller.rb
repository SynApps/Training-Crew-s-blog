class PostController < ApplicationController
  layout "master"
  
  def index
    @categories=Category.all
    slug=params[:category_slug]
    if(slug)
      @posts=Post.by_category(slug, 1000)
    else
      @posts=Post.recent_sorted(10)
    end
  end
  def rss  
    @posts=Post.recent_sorted(10)
  end
  def show
    @post= Post.find_by_slug(params[:slug])
    render '404' unless @post
  end
  
  def add_comment
    post = Post.find(params[:id]);
    comment = Comment.create!(:user => params[:name], :text => params[:comment])
    
    post.comments << comment
    post.save
    
    redirect_to :action => 'show', :slug => post.slug, :year =>  post.year, :month => post.month , :day => post.day
  end
  def add_reply
    post = Post.find(params[:id]);
    root_comment = post.comments.find(params[:reply_to])
    reply = Comment.create!(:user => params[:name], :text => params[:comment], :reply_to => root_comment.id)
    
    post.comments << comment
    post.save
    
    redirect_to :action => 'show', :slug => post.slug, :year =>  post.year, :month => post.month , :day => post.day
  end  
end
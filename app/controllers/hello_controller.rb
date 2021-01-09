class HelloController < ApplicationController 
  def index
    @post = Post.first
  end
end
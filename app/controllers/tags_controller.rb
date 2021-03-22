class TagsController < ApplicationController
  def index
    unless params[:input].empty?
      @tags = Tag.ransack(name_cont: params[:input]).result
    end

    respond_to do |format|
      format.html
      format.json
    end
  end
end

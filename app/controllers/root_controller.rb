class RootController < ApplicationController
  respond_to :json, :html

  def index
    respond_with []
  end
end

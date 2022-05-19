class PastesController < ApplicationController
  def index
    @pastes = current_user.pastes
  end

  def show
    @paste = current_user.pastes.where(uuid: params[:uuid]).first
  end

  def new
  end

  def update
  end
end

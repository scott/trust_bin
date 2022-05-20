class PastesController < ApplicationController
  def index
    @pastes = current_user.pastes.root
  end

  def show
    @paste = current_user.pastes.where(uuid: params[:uuid]).order(version: :desc).first
  end

  def new
    @paste = Paste.new
  end

  def fork
    paste = current_user.pastes.find_by(uuid: params[:paste_uuid])

    @paste = Paste.new(
      name: paste.name,
      content: paste.content,
      parent_id: paste.id,
      version: paste.version + 1
    )
  end

  def create
    @paste = Paste.new(paste_params)
    @paste.user_id = current_user.id
    @paste.uuid = SecureRandom.uuid
    if @paste.save
      redirect_to pastes_path
    else
      render :new
    end
  end

  private

  def paste_params
    params.require(:paste).permit(
      :name,
      :content,
      :parent_id
    )
  end
end

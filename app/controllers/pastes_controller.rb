class PastesController < ApplicationController
  def index
    @pastes = current_user.pastes.active.root
  end

  def show
    @paste = current_user.pastes.active.where(uuid: params[:uuid]).order(version: :desc).first
    @versions = current_user.pastes.active.where(parent_id: @paste.id).order(version: :desc)
  end

  def new
    @paste = Paste.new
  end

  def fork
    paste = current_user.pastes.active.find_by(uuid: params[:paste_uuid])

    @paste = Paste.new(
      name: paste.name,
      content: paste.content,
      parent_id: paste.id,
      version: paste.version + 1,
      description: paste.description,
      language: paste.language
    )

    render :new
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

  def destroy
    paste = current_user.pastes.find_by(uuid: params[:uuid])
    paste.deleted_at = Time.now
    paste.save!
    redirect_to pastes_path
  end

  private

  def paste_params
    params.require(:paste).permit(
      :name,
      :description,
      :language,
      :content,
      :parent_id,
      :version
    )
  end
end

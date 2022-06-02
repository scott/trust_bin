class SnippetsController < ApplicationController
  def index
    if params[:show].blank?
      @snippets = Snippet.active.org.root.all
    else
      @snippets = current_user.snippets.active.root
    end
  end

  def show
    if params[:version].present?
      @snippet = Snippet.find_by(uuid: params[:uuid])
    else
      @snippet = Snippet.where(parent_uuid: params[:uuid]).order(version: :desc).first
    end

    @versions = Snippet.where(parent_uuid: @snippet.parent_uuid).order(version: :desc)
  end

  def new
    @snippet = Snippet.new
  end

  def fork
    snippet = Snippet.active.find_by(uuid: params[:snippet_uuid])
    @snippet = Snippet.new(
      name: snippet.name,
      content: snippet.content,
      parent_uuid: snippet.parent_uuid,
      version: snippet.version + 1,
      description: snippet.description,
      language: snippet.language,
      visibility: snippet.visibility
    )

    render :new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    @snippet.user_id = current_user.id
    @snippet.uuid = SecureRandom.uuid
    if @snippet.save
      flash[:success] = "Snippet successfully created"
      redirect_to snippet_path(uuid: @snippet.uuid)
    else
      render :new
    end
  end

  def destroy
    snippet = current_user.snippets.find_by(uuid: params[:uuid])
    snippet.deleted_at = Time.now
    snippet.save!
    flash[:success] = "Snippet successfully deleted"
    redirect_to snippets_path
  end

  private

  def snippet_params
    params.require(:snippet).permit(
      :name,
      :description,
      :language,
      :content,
      :parent_uuid,
      :version,
      :visibility
    )
  end
end

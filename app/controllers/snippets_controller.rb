class SnippetsController < ApplicationController
  def index
    @snippets = current_user.snippets.active.root
  end

  def show
    @snippet = current_user.snippets.active.where(uuid: params[:uuid]).order(version: :desc).first
    @versions = current_user.snippets.active.where(parent_id: @snippet.id).order(version: :desc)
    @current = @versions.size > 0 ? @versions.first : @snippet
  end

  def new
    @snippet = Snippet.new
  end

  def fork
    snippet = current_user.snippets.active.find_by(uuid: params[:snippet_uuid])

    @snippet = Snippet.new(
      name: snippet.name,
      content: snippet.content,
      parent_id: snippet.id,
      version: snippet.version + 1,
      description: snippet.description,
      language: snippet.language
    )

    render :new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    @snippet.user_id = current_user.id
    @snippet.uuid = SecureRandom.uuid
    if @snippet.save
      redirect_to snippets_path
    else
      render :new
    end
  end

  def destroy
    snippet = current_user.snippets.find_by(uuid: params[:uuid])
    snippet.deleted_at = Time.now
    snippet.save!
    redirect_to snippets_path
  end

  private

  def snippet_params
    params.require(:snippet).permit(
      :name,
      :description,
      :language,
      :content,
      :parent_id,
      :version
    )
  end
end

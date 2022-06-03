class Snippet < ApplicationRecord
  belongs_to :user

  encrypts :content
  encrypts :name, deterministic: true
  encrypts :description, deterministic: true

  scope :org, -> { where(visibility: 'org') }
  scope :priv, -> { where(visibility: 'private') }
  scope :root, -> { where(version: 1) }
  scope :active, -> { where(deleted_at: nil) }
  scope :latest, -> { order(version: :desc) }

  LANGUAGES = [
    "shell",
    "javascript",
    "ruby",
    "htmlmixed",
    "go",
    "python",
    "php",
    "css",
    "dockerfile",
    "elixir",
    "earlang",
    "java",
    "markdown",
    "php",
    "rust",
    "yaml"
  ].sort.freeze

  def parent
    Snippet.find_by(parent_uuid: uuid, version: 1)
  end

  def versions
    Snippet.where("parent_uuid = ?", uuid)
  end
end

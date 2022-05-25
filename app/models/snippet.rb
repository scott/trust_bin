class Snippet < ApplicationRecord
  belongs_to :user

  encrypts :content
  encrypts :name, deterministic: true
  encrypts :description, deterministic: true

  scope :org, -> { where(visibility: 'org') }
  scope :priv, -> { where(visibility: 'private') }
  scope :root, -> { where(parent_id: nil) }
  scope :active, -> { where(deleted_at: nil) }

  LANGUAGES = [
    "shell",
    "javascript",
    "ruby",
    "htmlmixed",
    "go",
    "python",
    "php"
  ]

  def parent
    Snippet.find_by(parent_id: parent_id)
  end

  def versions
    Snippet.where("id = ? OR parent_id = ? OR parent_id = ? OR id = ?", id, id, parent_id, parent_id)
  end
end

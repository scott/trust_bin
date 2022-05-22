class Snippet < ApplicationRecord
  belongs_to :user

  encrypts :content
  encrypts :name

  scope :pub, -> { where(private: false) }
  scope :priv, -> { where(private: true) }
  scope :root, -> { where(parent_id: nil) }
  scope :active, -> { where(deleted_at: nil) }
end

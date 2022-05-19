class Paste < ApplicationRecord
  belongs_to :user

  encrypts :content
  encrypts :name

  scope :pub, -> { where(private: false) }
  scope :priv, -> { where(private: true) }
end

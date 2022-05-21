class CreatePastes < ActiveRecord::Migration[7.0]
  def change
    create_table :pastes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uuid, index: true
      t.string :shortlink, index: true
      t.string :language
      t.string :name
      t.string :description
      t.text :content
      t.boolean :private, default: true
      t.datetime :deleted_at
      t.integer :parent_id
      t.integer :version, default: 1

      t.timestamps
    end
  end
end

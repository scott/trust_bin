class CreateSnippets < ActiveRecord::Migration[7.0]
  def change
    create_table :snippets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uuid, index: true
      t.string :shortlink, index: true
      t.string :language
      t.string :name
      t.string :description
      t.text :content
      t.string :visibility, default: 'private'
      t.datetime :deleted_at
      t.string :parent_uuid, index: true
      t.integer :version, default: 1

      t.timestamps
    end
  end
end

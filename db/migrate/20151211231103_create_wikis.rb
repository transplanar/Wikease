class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
      # IDEA refactor :private into better name? (implies others shouldn't see it)
      # TODO set default to false
      t.boolean :private, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

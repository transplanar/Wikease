class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
      # REVIEW (mid) is this the best way to make this value default?
      t.boolean :private, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

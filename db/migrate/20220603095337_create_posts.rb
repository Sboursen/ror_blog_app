class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string      :title
      t.text        :text
      t.integer     :comments_count, default: 0
      t.integer     :likes_count, default: 0
      t.references  :user, foreign_key: true
      t.timestamps
    end
  end
end

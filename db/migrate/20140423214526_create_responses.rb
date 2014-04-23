class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :ad_id, null: false
      t.integer :respondent_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :respondable_id, null: false
      t.integer :respondable_type, null: false

      t.timestamps
    end

    add_index :responses, :ad_id
    add_index :responses, :respondent_id
    add_index :responses, :title
    add_index :responses, :respondable_id
  end
end

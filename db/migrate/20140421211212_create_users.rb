class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.string :username
      t.boolean :is_admin, default: false
      t.boolean :wants_forwarded_responses, default: true

      t.timestamps
    end
    
    add_index :users, :email, unique: true
    add_index :users, :password_digest
    add_index :users, :session_token
    
  end
end

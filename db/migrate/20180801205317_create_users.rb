class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :access_token
      t.string :refresh_token
      t.integer :uid
      t.integer :access_token_expires_at

      t.timestamps
    end
  end
end

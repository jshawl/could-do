class AddIcsUpdatedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ics_updated_at, :datetime
  end
end

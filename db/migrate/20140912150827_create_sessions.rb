class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :logins
      t.timestamps
    end
  end
end

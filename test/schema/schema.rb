ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
    t.string :email, null: false
    t.timestamps null: false
  end

  create_table :deleted_users, force: true do |t|
    t.string :name
    t.string :email, null: false
    t.timestamps null: false
    t.datetime :deleted_at
  end
end

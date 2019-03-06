require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :mail_opt_out_subscriptions do |t|
    t.references :list
    t.references :user, polymorphic: true
    t.timestamps null: false
  end

  create_table :mail_opt_out_lists do |t|
    t.string :number
    t.string :name
    t.text :description
    t.boolean :published, default: false

    t.timestamps null: false
  end
end

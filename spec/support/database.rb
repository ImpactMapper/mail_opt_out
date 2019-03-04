require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :mail_opt_out_subscriptions do |t|
    t.string :list
    t.references :user, polymorphic: true
    t.timestamps
  end
end

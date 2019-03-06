class CreateMailOptOutSubscriptions < ActiveRecord::Migration
  def change
    create_table :mail_opt_out_subscriptions do |t|
      t.references :list
      t.references :user, polymorphic: true, index: true

      t.timestamps
    end
  end
end

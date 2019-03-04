class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :list, index: true

      t.references :user, polymorphic: true, index: true

      t.timestamps
    end
  end
end

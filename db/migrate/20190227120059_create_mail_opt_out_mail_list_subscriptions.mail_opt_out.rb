class CreateMailOptOutMailListSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_list_subscriptions do |t|
      t.string :email, index: true
      t.string :list, index: true

      t.references :user, polymorphic: true

      t.timestamps
    end

    # Shorten name
    add_index :mail_list_subscriptions, [:user_type, :user_id], name: :index_mail_subscriptions_on_polymorphic_user
  end
end

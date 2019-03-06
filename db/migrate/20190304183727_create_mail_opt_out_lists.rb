class CreateMailOptOutLists < ActiveRecord::Migration
  def change
    create_table :mail_opt_out_lists do |t|
      t.string :number
      t.string :name
      t.text :description
      t.boolean :published, default: false

      t.timestamps
    end
  end
end

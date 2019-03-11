class CreateMailOptOutLists < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_opt_out_lists do |t|
      t.string :number
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

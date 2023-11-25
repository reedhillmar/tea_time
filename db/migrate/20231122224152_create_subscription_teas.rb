class CreateSubscriptionTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_teas do |t|
      t.references :subscription, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end

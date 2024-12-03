class CreateProposals < ActiveRecord::Migration[7.1]
  def change
    create_table :proposals do |t|
      t.decimal :amount, null: false
      t.integer :tax_factor, null: false
      t.integer :payment_term, null: false

      t.timestamps
    end
  end
end

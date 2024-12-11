class AddLoanSimulationAtributtesToProposals < ActiveRecord::Migration[7.1]
  def change
    add_column :proposals, :total_payment, :decimal
    add_column :proposals, :monthly_payment, :decimal
    add_column :proposals, :total_interest, :decimal
  end
end

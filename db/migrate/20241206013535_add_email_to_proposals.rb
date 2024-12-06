class AddEmailToProposals < ActiveRecord::Migration[7.1]
  def change
    enable_extension('citext')
    add_column :proposals, :email, :citext, null: false
  end
end

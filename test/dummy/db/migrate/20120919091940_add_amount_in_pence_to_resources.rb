class AddAmountInPenceToResources < ActiveRecord::Migration

  def change
    add_column :resources, :amount_in_pence, :integer
  end

end

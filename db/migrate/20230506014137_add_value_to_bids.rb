class AddValueToBids < ActiveRecord::Migration[7.0]
  def change
    add_column :bids, :value, :integer
  end
end

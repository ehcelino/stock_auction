class RemoveStatusFromQna < ActiveRecord::Migration[7.0]
  def change
    remove_column :qnas, :status, :integer
  end
end

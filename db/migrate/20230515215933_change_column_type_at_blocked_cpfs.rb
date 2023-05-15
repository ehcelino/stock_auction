class ChangeColumnTypeAtBlockedCpfs < ActiveRecord::Migration[7.0]
  def change
    change_column :blocked_cpfs, :cpf, :string
  end
end

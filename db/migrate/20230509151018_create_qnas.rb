class CreateQnas < ActiveRecord::Migration[7.0]
  def change
    create_table :qnas do |t|
      t.string :question
      t.string :answer
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end

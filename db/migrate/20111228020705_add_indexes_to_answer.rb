class AddIndexesToAnswer < ActiveRecord::Migration
  def change
    add_index :answers, :question_number
  end
end

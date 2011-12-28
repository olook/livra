class AddFieldsToAnswer < ActiveRecord::Migration
  def change
    rename_column :answers, :profile, :profile_name
    add_column :answers, :question_number, :integer
    add_column :answers, :profile_code, :integer
    add_column :answers, :confirmed, :boolean
  end
end

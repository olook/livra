class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :user
      t.string :image
      t.string :profile

      t.timestamps
    end

    add_index :answers, :user
    add_index :answers, :image
    add_index :answers, :profile
  end
end

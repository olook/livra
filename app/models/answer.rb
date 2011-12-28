class Answer < ActiveRecord::Base
  scope :confirmed, where(:confirmed => true)
  scope :unconfirmed, where(:confirmed => false)
  scope :by_user, order(:user)
  scope :by_question_number, order(:question_number)
end

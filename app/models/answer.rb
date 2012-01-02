class Answer < ActiveRecord::Base
  scope :confirmed, where(:confirmed => true)
  scope :unconfirmed, where(:confirmed => false)
  scope :by_user, order('answers.user')
  scope :by_question_number, order(:question_number)
  scope :confirmed_users, select('DISTINCT answers.user').confirmed.by_user
end

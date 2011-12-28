class Answer < ActiveRecord::Base
  scope :confirmed, where(:confirmed => true)
  scope :unconfirmed, where(:confirmed => false)
  scope :by_user, order('answers.user')
  scope :by_question_number, order(:question_number)

  def self.confirmed_users
    Answer.select('DISTINCT answers.user').confirmed.count
  end
end

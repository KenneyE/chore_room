# == Schema Information
#
# Table name: chores
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  day        :string(255)
#

class Chore < ActiveRecord::Base
  validates :title, :day, presence: true
  
  has_many :chore_assignments
  has_many :users, through: :chore_assignments, source: :user

  # Refactor to work with ChoreAssignments
  def self.assign_chores!(user_ids)
    user_list = user_ids.shuffle!
    user_list += user_list.shuffle! until user_list.length >= Chore.count
    self.all.each { |chore| ChoreAssignment.create({
      chore_id: chore.id, 
      user_id: user_list.shift, 
      due_date: Chronic.parse("#{chore.day}")}) }
  end

  def current_assignments
    self.chore_assignments.where(completed: false)
  end
end

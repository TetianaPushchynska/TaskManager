class User < ApplicationRecord
  ROLES = {
    task_author: 'Task Author'
  }.freeze

  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :tasks

  validates_presence_of :first_name, :last_name

  def task_author?
    role == ROLES[:task_author]
  end
end

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

  def today_task_activity
    start_of_day = Time.now.utc.beginning_of_day
    tasks.with_deleted.where('created_at >= ? OR updated_at >= ?', start_of_day, start_of_day).count
  end
end

class ChangePriorityTypeInTasks < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :priority, :integer, using: 'priority::integer'
  end
end

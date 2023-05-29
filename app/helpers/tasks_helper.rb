module TasksHelper
  DOT_COLORS = { high: 'danger', medium: 'warning', low: 'green' }.freeze

  def dot_status(task)
    content_tag(:span, "#{task.priority.capitalize}",
      class: "label label-#{DOT_COLORS[task.priority.to_sym]}"
    )
  end
end

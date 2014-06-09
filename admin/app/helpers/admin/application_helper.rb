module Admin::ApplicationHelper
  def flash_class(level)
    case level
    when :success then "alert alert-success"
    when :notice then "alert alert-info"
    when :alert then "alert alert-danger"
    when :error then "alert alert-danger"
    end
  end

  def true_false_icon(state)
    if state
      '<i class="glyphicon glyphicon-ok green"></i>'.html_safe
    else
      '<i class="glyphicon glyphicon-remove"></i>'.html_safe
    end
  end
end

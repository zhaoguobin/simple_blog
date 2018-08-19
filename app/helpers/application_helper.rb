module ApplicationHelper

  def active_class(active_controller, active_action = nil)
    if controller_name == active_controller
      'active' unless active_action.present? && action_name != active_action
    end
  end

  def show_time(datetime)
    datetime.strftime("%Y-%m-%d %H:%M:%S") if datetime.present?
  end

  def show_date(datetime)
    datetime.strftime("%Y-%m-%d") if datetime.present?
  end
  
end

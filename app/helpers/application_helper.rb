module ApplicationHelper

  def active_class(active_controller, active_action = nil)
    if controller_name == active_controller
      'active' unless active_action.present? && action_name != active_action
    end
  end
  
end

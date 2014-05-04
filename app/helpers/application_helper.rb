module ApplicationHelper
  def alert_category(flash_category)
    if flash_category == 'error'
      'danger'
    elsif ['info', 'notice'].include?(flash_category)
      'info'
    elsif flash_category == 'success'
      'success'
    elsif flash_category == 'warning'
      'warning'
    else
      'info'
    end
  end
end

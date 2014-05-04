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

  def number_of_mutants(task)
    if task.mutants.count == 1
      '1 Mutant'
    elsif task.mutants.count > 1
      "#{task.mutants.count} Mutants"
    else
      'No Mutant'
    end
  end
end

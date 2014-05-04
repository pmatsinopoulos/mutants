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

  def number_of_mutants(task_or_group)
    if task_or_group.mutants.count == 1
      '1 Mutant'
    elsif task_or_group.mutants.count > 1
      "#{task_or_group.mutants.count} Mutants"
    else
      'No Mutant'
    end
  end

  def number_of_tasks(group)
    if group.tasks.count == 1
      '1 Task'
    elsif group.tasks.count > 1
      "#{group.tasks.count} Tasks"
    else
      'No Task'
    end    
  end
end

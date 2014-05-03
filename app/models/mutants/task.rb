module Mutants
  class Task < ActiveRecord::Base
    belongs_to :group, class_name: 'Mutants::Group', inverse_of: :tasks
    validates :name, presence: true, uniqueness: {case_sensitive: false}

    nilify_blanks
  end
end
module Mutants
  class Group < ActiveRecord::Base
    validates :name, presence: true, uniqueness: {case_sensitive: false}

    has_many :mutants, class_name: 'Mutants::Mutant', inverse_of: :group
    has_many :tasks,   class_name: 'Mutants::Task',   inverse_of: :group

  end
end
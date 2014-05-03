module Mutants
  class Mutant < ActiveRecord::Base
    belongs_to :group, class_name: 'Mutants::Group', inverse_of: :mutants

    validates :name, presence: true, uniqueness: {case_sensitive: false}

    nilify_blanks
  end
end
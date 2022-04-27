class Project < ApplicationRecord
  enum status: %i[notyet doing done]

  belongs_to :mission
end

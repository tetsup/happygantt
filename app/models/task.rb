class Task < ApplicationRecord
  belongs_to :requirement

  def planned; end
  def actual; end
end

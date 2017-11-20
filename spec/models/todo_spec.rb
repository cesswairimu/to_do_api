require 'rails_helper'

RSpec.describe Todo, type: :model do
  #Association test
  #ensure to do model has a relationship with item model
it { should have_many(:items).dependent(:destroy) }

  #Validation tests
  #ensure columns title and created_by are present before saving
  it { should validate :title }
  it { should  validate created_by }
end

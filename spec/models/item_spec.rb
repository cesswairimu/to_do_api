require 'rails_helper'

RSpec.describe Item, type: :model do
  #Association test
  #ensure item record belongs to a single todo record
  it { should belong_to(:todo) }
    
  #Validation test
  #ensure column name is present before save
  it { should validate (:name) }
end

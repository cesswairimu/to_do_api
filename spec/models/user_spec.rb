require 'rails_helper'

RSpec.describe User, type: :model do
  #Association test
  #Ensure user has 1:m relation with a todo model
  it { should (have_many :todos) }
  #Validation tests name, email and password_digest
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end

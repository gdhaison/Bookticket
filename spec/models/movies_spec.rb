require 'rails_helper'
require 'shoulda/matchers'
RSpec.describe Movie, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:category_id) }
  it { should validate_uniqueness_of(:name) }
end

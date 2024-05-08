require 'rails_helper'

RSpec.describe(Match) do
  
  describe 'associations' do
    it { is_expected.to(belong_to(:first_team)) }
    it { is_expected.to(belong_to(:second_team)) }
  end
end

require 'rails_helper'

RSpec.describe(MatchIndicator) do
  
  describe 'associations' do
    it { is_expected.to(belong_to(:player)) }
    it { is_expected.to(belong_to(:indicator)) }
    it { is_expected.to(belong_to(:match)) }
  end
end

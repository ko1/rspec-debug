RSpec.describe RSpec::Debug do
  it "has a version number" do
    expect(RSpec::Debug::VERSION).not_to be nil
  end
end

if ENV['RSPEC_DEBUG']
  # failure test
  require_relative '../lib/rspec/debug'

  RSpec.describe 'try debug, 1st' do
    it 'should fail and debugger' do
      a = true
      expect(a).to be false
    end

    it 'should fail and debugger, 2nd' do
      a = 42
      expect(a).to be 43
    end

  end
end


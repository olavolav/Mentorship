require 'spec_helper'

describe MentorshipAssigner do

  subject { MentorshipAssigner.new(developers) }
  let(:developers) { [] }

  context 'when there are no developers' do

    it 'returns nil' do
      expect(subject.perform).to eq({})
    end

  end

  context 'when there is only one developer' do

    let(:alice) { double(:developer, senior?: false, junior?: true) }
    let(:developers) { [alice] }

    it 'returns nil' do
      expect(subject.perform).to eq({})
    end

  end

  context 'when there are only two developers' do

    let(:alice) { double(:developer, senior?: true, junior?: false) }
    let(:bob) { double(:developer, senior?: false, junior?: true) }
    let(:developers) { [alice, bob] }

    it 'returns nil' do
      expect(subject.perform).to eq({})
    end

  end

  context 'when there a higher number of developers' do

    let(:alice) { double(:developer, senior?: true, junior?: false) }
    let(:bob) { double(:developer, senior?: true, junior?: false) }
    let(:cassie) { double(:developer, senior?: false, junior?: true) }
    let(:deryl) { double(:developer, senior?: false, junior?: true) }
    let(:developers) { [alice, bob, cassie, deryl] }

    it 'returns a valid assignment' do
      result = subject.perform

      mentors = result[alice]
      expect(mentors.first).to eq(bob)
      expect([cassie, deryl]).to include(mentors.last)

      mentors = result[bob]
      expect(mentors.first).to eq(alice)
      expect([cassie, deryl]).to include(mentors.last)

      mentors = result[cassie]
      expect([alice, bob]).to include(mentors.first)
      expect(mentors.last).to eq(deryl)

      mentors = result[deryl]
      expect([alice, bob]).to include(mentors.first)
      expect(mentors.last).to eq(cassie)
    end

  end

end

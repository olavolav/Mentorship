require 'rails_helper'

describe Developer do

  describe '#senior?' do

    let!(:alice) { create(:developer, name: 'Alice', starting_date: Time.new(2011, 1, 1)) }

    context 'when there is only one developer present' do
      it 'defaults to senior' do
        expect(alice).to be_senior
      end
    end

    context 'when there is an even number of developers present' do

      let!(:bob) { create(:developer, name: 'Bob', starting_date: Time.new(2015, 1, 1)) }

      it 'assigns seniority labels correctly' do
        expect(alice).to be_senior
        expect(bob).to be_junior
      end

    end

    context 'when there is an odd number of developers present' do

      let!(:bob) { create(:developer, name: 'Bob', starting_date: Time.new(2015, 1, 1)) }
      let!(:cassie) { create(:developer, name: 'Cassie', starting_date: Time.new(2010, 1, 1)) }

      it 'assigns seniority labels correctly (bias towards more junior devs)' do
        expect(alice).to be_junior
        expect(bob).to be_junior
        expect(cassie).to be_senior
      end

    end

    context 'when some developers are working part-time only' do

      let!(:bob) { create(:developer, name: 'Bob', starting_date: Time.new(2015, 1, 1)) }
      let!(:cassie) do
        create(:developer, name: 'Cassie', starting_date: Time.new(2011, 1, 1), part_time: true)
      end

      it 'assigns seniority labels correctly (ignoring part-time devs)' do
        expect(alice).to be_senior
        expect(bob).to be_junior
        expect(cassie).to be_senior
      end

    end

  end

end

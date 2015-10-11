require 'rails_helper'

describe Developer do

  describe '#senior?' do

    context 'when there is only one developer present' do

      let!(:alice) { create(:developer) }

      it 'defaults to senior' do
        expect(alice).to be_senior
      end

    end

    context 'when there is an even number of developers present' do

      let!(:alice) { create(:developer, name: 'Alice', starting_date: Time.new(2011, 1, 1)) }
      let!(:bob) { create(:developer, name: 'Bob', starting_date: Time.new(2015, 1, 1)) }

      it 'assigns seniority labels correctly' do
        expect(alice).to be_senior
        expect(bob).to be_junior
      end

    end

    context 'when there is an odd number of developers present' do

      let!(:alice) { create(:developer, name: 'Alice', starting_date: Time.new(2011, 3, 1)) }
      let!(:bob) { create(:developer, name: 'Bob', starting_date: Time.new(2015, 1, 1)) }
      let!(:cassie) { create(:developer, name: 'Cassie', starting_date: Time.new(2011, 1, 1)) }

      it 'assigns seniority labels correctly (bias towards more junior devs)' do
        # byebug
        expect(alice).to be_junior
        expect(bob).to be_junior
        expect(cassie).to be_senior
      end

    end

  end

end

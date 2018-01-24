require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advertisement) { Advertisement.create!(title:"New Ad Title", copy:"New Ad Copy", price:100)}

  describe "attributes" do
    it "has a body attribute" do
      expect(advertisement).to have_attributes(title:"New Ad Title", copy:"New Ad Copy", price:100)
    end
  end
end

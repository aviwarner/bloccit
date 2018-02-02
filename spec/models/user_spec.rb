require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: "Bloccit User", email:"user@bloccit.com", password: "password" ) }

#Shoulda tests for name
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

#Shoulda tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }

#Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: "Bloccit User", email:"user@bloccit.com")
    end

    it "should correctly capitalize a users name when uppercase" do
      user.name = "BLOC USER"
      user.save
      expect(user.name).to eq("Bloc User")
    end

    it "should correctly capitalize a users name when lowercase" do
      user.name = "bloc user also"
      user.save
      expect(user.name).to eq("Bloc User Also")
    end

    it "should not change correctly capitalized users name" do
      user.name = "Last User"
      user.save
      expect(user.name).to eq("Last User")
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_name) { User.new(name:"", email:"user@bloccit.com")}
    let(:user_with_invalid_email) { User.new(name:"Bloccit User", email:"")}

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  # describe "name capitalization" do
  #   let(:user_with_uncapitalized_name) { User.new(name:"joe sample", email:"user@bloccit.com") }
  #   let(:user_with_allcapitalized_name) { User.new(name:"JOE SAMPLE", email:"user@bloccit.com") }
  #
  #   it "should convert lowercase name to capitalized name" do
  #     expect(user_with_uncapitalized_name).to have_attributes(name: "Joe Sample", email:"user@bloccit.com")
  #   end
  #
  #   it "should convert all uppercase name to capitalized name" do
  #     expect(user_with_allcapitalized_name).to have_attributes(name: "Joe Sample", email:"user@bloccit.com")
  #   end
  #
  # end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  first_name             :string
#  last_name              :string
#  city                   :string
#  slug                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a last_name" do
    user = build(:user, last_name: nil)
    user.valid?
    expect(user).to be_invalid
  end

  it "is invalid without a first_name" do
    user = build(:user, first_name: nil)
    user.valid?
    expect(user).to be_invalid
  end

  it "is invalid without a city" do
    user = build(:user, city: nil)
    user.valid?
    expect(user).to be_invalid
  end

  it "sets a slug automatically" do
    user = create(:user, slug: nil)
    expect(user.slug).not_to be_nil
  end
end

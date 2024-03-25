# == Schema Information
#
# Table name: helloasso_tokens
#
#  id            :uuid             not null, primary key
#  access_token  :text
#  refresh_token :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class HelloassoToken < ApplicationRecord
end

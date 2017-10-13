# == Schema Information
#
# Table name: cavy_resources
#
#  id         :integer          not null, primary key
#  url        :string
#  name       :string
#  file_type  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Cavy
  class Resource < ApplicationRecord
  end
end

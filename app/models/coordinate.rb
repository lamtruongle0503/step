# == Schema Information
#
# Table name: coordinates
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  latitude    :float
#  longitude   :float
#  module_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  module_id   :bigint
#
# Indexes
#
#  index_coordinates_on_module  (module_type,module_id)
#
class Coordinate < ApplicationRecord
  belongs_to :module, polymorphic: true
  belongs_to :prefecture, foreign_key: :module_id, optional: true
  belongs_to :district, foreign_key: :module_id, optional: true
end

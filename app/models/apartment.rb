class Apartment < ApplicationRecord
    has_many :tenants, through: :leases
end

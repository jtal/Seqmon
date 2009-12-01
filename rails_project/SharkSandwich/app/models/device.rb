class Device < ActiveRecord::Base
    acts_as_pushable :token
    has_many :flowcell_subscriptions
end

class Device < ActiveRecord::Base
    acts_as_pushable :token
end

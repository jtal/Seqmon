class PusherController < ApplicationController
   def demo
        devs = Device.find(:all);

	devs.each do |dev|
	        dev.send_notification :alert => "I like ponies!", :badge=>10
	end
    end
end

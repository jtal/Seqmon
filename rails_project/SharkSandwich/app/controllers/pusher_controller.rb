class PusherController < ApplicationController
    def demo
        dev = Device.find(:first)

        dev.send_notification :alert => "HELLOOOOOOO!"

    end
end

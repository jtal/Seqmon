class FlowcellsController < ApplicationController

    skip_before_filter :verify_authenticity_token

    def register_flowcell_notify
        flowcell_id = params[:id];
        token = params[:token];

        dev = Device.find_by_token(token);

        if dev 
            efc = FlowcellSubscription.find(:first, :conditions => { :flowcell_id => flowcell_id, :device_id => dev.id});
           
            if (efc && params[:status] == "off")
                efc.destroy();
            elsif (!efc) 
                efc = FlowcellSubscription.create(:flowcell_id => flowcell_id,
                                                  :device_id => dev.id);
                efc.save
            end

            render :json => {:flowcell => flowcell_id}
        end
    end

    def get_notification_data
        dev = Device.find_by_token(params[:id])

        flowcell_subscriptions = Array.new()

        if dev
            fcs = FlowcellSubscription.find(:all, :conditions => {:device_id => dev.id})
            
            fcs.each do |fc|
                flowcell_subscriptions.push fc.flowcell_id;
            end
        end

        render :json => {:flowcell_subscriptions => flowcell_subscriptions}
    end


    def notify_flowcell_subscribers
        flowcell_id = params[:flowcell_id];
        event = params[:event];

        notificationString = ""
    
        fcs = FlowcellSubscription.find(:all, :conditions => {:flowcell_id => flowcell_id}); 
        if event == "finished"
            notificationString = "Flowcell #{flowcell_id} has completed"
        end

        fcs.each do |fc|
           fc.device.send_notification :alert => notificationString
        end 

        render :json => {:number_notified => fcs.size}
    end
end

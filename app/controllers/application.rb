# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
	#before_filter :authenticate
	
  protected
  def authenticate
    authenticate_or_request_with_http_basic do |name, pass|
      	name == 'admin' && pass == 'admin123'
      end
  end
	
	def load_campaign
		@campaign = Campaign.find(params[:campaign_id])		
	end
	
  # try and load campaign only if the zone controller
	# has been invoked in a campaign context
	def check_and_load_campaign
    load_campaign unless params[:campaign_id].nil?
	end
	
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '06d4bb90ba265d3b01c1737e2b0c258f'
end

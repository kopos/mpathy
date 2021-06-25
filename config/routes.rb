# See how all your routes lay out with "rake routes"
ActionController::Routing::Routes.draw do |map|
 
  map.root :controller => 'dashboard'
  
  # active and inactive work very similar to campaigns/list
  # map.resources :campaigns, :collection => [:active, :inactive]
  #
  # campaign/1/assets
  # campaign/1/logs
  # campaign/1/stats
  # campaign/1/schedules
  # campaign/1/reports/view/TYPE
  # campaign/1/reports/data/TYPE
  # 
	map.resources :campaigns, :collection => [:active, :inactive],
														:has_many   => [:logs, :stats, :schedules]
  map.resources :campaigns do |campaign|
    campaign.resources :assets, :member => [:download]
    campaign.resources :zones,  :member => [:attach]
    campaign.resources :reports,:collection => [:view, :data]
  end																					  
  
  # Beamers, Zones can also be created independently
	map.resources :zones,     :has_many   => [:beamers, :campaigns], :member => [:add]
	map.resources :beamers,   :has_many   => [:zones], :member => [:logs, :campaigns]
  map.resources :reports,   :collection => [:view, :data]
  
  #map.connect "campaigns/:campaign_id/reports/view/:type"
  #map.connect "campaigns/:campaign_id/reports/data/:type"

  # Install the default routes as the lowest priority.
  map.connect ":controller/:action/:id"
  map.connect ":controller/:action/:id.:format"
end

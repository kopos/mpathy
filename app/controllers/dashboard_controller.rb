class DashboardController < ApplicationController

  def index
    @campaign_cnt  = Campaign.count
    @acampaign_cnt = Campaign.count(:id, :conditions => "status = 'active'")
    @icampaign_cnt = Campaign.count(:id, :conditions => "status = 'inactive'")
    @ccampaign_cnt = Campaign.count(:id, :conditions => "status = 'closed'")

    @zone_cnt      = Zone.count
    @beamer_cnt    = Beamer.count
  end
end

class CampaignsController < ApplicationController
  # GET /campaigns
  # GET /campaigns.xml
  def index
    @campaigns          = Campaign.find(:all)
    @active_campaigns   = @campaigns.select  {|campaign| campaign if campaign.status == "active" }
    @inactive_campaigns = @campaigns.select  {|campaign| campaign unless campaign.status == "active" }

    #@campaign_cnt  = Campaign.count

    #@cmpgn_cnt          = @campaigns.length
    #@act_cmpgn_cnt      = @active_campaigns.length
    #@inact_cmpgn_cnt    = @inactive_campaigns.length
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @campaigns }
    end
  end

  # GET /campaigns/new
  # GET /campaigns/new.xml
  def new
    @campaign = Campaign.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campaign }
    end
  end
  
  # GET /campaigns/1
  # GET /campaigns/1.xml
  def show
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /campaigns/1/edit
  def edit
    @campaign = Campaign.find(params[:id])
  end

  # POST /campaigns
  # POST /campaigns.xml
  def create
    @campaign = Campaign.new(params[:campaign])

    respond_to do |format|
      if @campaign.save
        flash[:notice] = 'Campaign was successfully created.'
        format.html { redirect_to(@campaign) }
        format.xml  { render :xml => @campaign, :status => :created, :location => @campaign }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /campaigns/1
  # PUT /campaigns/1.xml
  def update
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        flash[:notice] = 'Campaign was successfully updated.'
        format.html { redirect_to(@campaign) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.xml
  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to(campaigns_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /campaigns/active
  # GET /campaigns/active.xml
  # map.resources :campaigns, :collection => [:active]
  def active
    @campaigns        = Campaign.find(:all, :conditions => ['status = ?', 'active'])
    @act_cmpgn_cnt    = @campaigns.length
    @inact_cmpgn_cnt  = Campaign.count - @campaigns.length
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @campaigns }
    end
  end

  # GET /campaigns/inactive
  # GET /campaigns/inactive.xml
  # map.resources :campaigns, :collection => [:inactive]
  def inactive
    @campaigns        = Campaign.find(:all, :conditions => ['status != ?', 'active'])
    @act_cmpgn_cnt    = Campaign.count - @campaigns.length
    @inact_cmpgn_cnt  = @campaigns.length

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @campaigns }
    end
  end

  # GET /campaigns/1/setup
  # GET /campaigns/1/setup.xml
  #def setup
  #  @campaign = Campaign.find(params[:id])
  #end
  
  # GET /campaigns/1/blacklist
  # GET /campaigns/1/blacklist.xml
  def blacklist
    @campaign = Campaign.find(params[:id])
  end
  
end

class ZonesController < ApplicationController
	# for those cases where the zones controller is 
	# being called from a campaign context.
	#     /campaign/:id/zones/
	before_filter :check_and_load_campaign
	
  # GET /zones
  # GET /zones.xml
  def index
    if @campaign.nil?
      @zones = Zone.find(:all)      
    else
      # zones resource invoked under a campaign resource
      @zones = @campaign.zones
      render :action => '../campaigns/zones/show'
      return false
    end
      
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @zones }
    end
  end

  # GET /zones/1
  # GET /zones/1.xml
  def show
    @zone = Zone.find(params[:id])
		@beamers = @zone.beamers

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @zone }
    end
  end

  # GET /zones/new
  # GET /zones/new.xml
  def new
    @zone = Zone.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @zone }
    end
  end

  # GET /zones/1/edit
  def edit
    @zone = Zone.find(params[:id])
  end

  # POST /zones
  # POST /zones.xml
  def create
    @zone = Zone.new(params[:zone])

    respond_to do |format|
      if @zone.save
        flash[:notice] = 'Zone was successfully created.'

        @zones = Zone.find(:all)
        format.html { render :action => 'index' }
        format.xml  { render :xml => @zone, :status => :created, :location => @zone }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @zone.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /zones/1
  # PUT /zones/1.xml
  def update
    @zone = Zone.find(params[:id])

    respond_to do |format|
      if @zone.update_attributes(params[:zone])
        flash[:notice] = 'Zone was successfully updated.'
        format.html { 
          add
          redirect_to(@zone) 
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @zone.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /zones/1
  # DELETE /zones/1.xml
  def destroy
    @zone = Zone.find(params[:id])

    if @campaign.nil?
      @zone.destroy
    else
      @campaign.zones.delete(@zone)
      
      redirect_to(campaign_zones_url(@campaign.id))
      return false
    end

    respond_to do |format|
      format.html { redirect_to(zones_url) }
      format.xml  { head :ok }
    end
  end

  def attach
    # add a zone to the campaign only IF it does not already exist
    @campaign.zones.push(Zone.find(params[:zone_ids]).select {|z| !@campaign.zones.include?(z)} ) if params[:zone_ids]

    if @campaign.save!
      @zones  = @campaign.zones

      respond_to do |format|
        format.html { redirect_to(campaign_zones_url(@campaign.id)) }
        format.xml  { head :ok }
      end
    end
  end
  
  def add
    # add the beamer to the zone IFF it is not attached to it
    @zone.beamers.push(Beamer.find(params[:beamer_ids]).select { |b| !@zone.beamers.include?(b) } ) if params[:beamer_ids]
    if @zone.save!
      @beamers = @zone.beamers
    end
  end

end

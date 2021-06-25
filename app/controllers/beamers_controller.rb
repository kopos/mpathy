class BeamersController < ApplicationController
  before_filter :check_and_load_zone

  def check_and_load_zone
    unless params[:zone_id].nil?
      @zone = Zone.find(params[:zone_id])
      @mode = :nested
    else
      @mode = :standalone
    end
  end

  # GET /beamers
  # GET /beamers.xml
  def index
    if @mode == :standalone
      @beamers = Beamer.find(:all)
    else
      @beamers = @zone.beamers
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @beamers }
    end
  end

  # GET /beamers/1
  # GET /beamers/1.xml
  def show
    @beamer = Beamer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @beamer }
    end
  end

  # GET /beamers/new
  # GET /beamers/new.xml
  def new
    @beamer = Beamer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @beamer }
    end
  end

  # GET /beamers/1/edit
  def edit
    @beamer = Beamer.find(params[:id])
  end

  # POST /beamers
  # POST /beamers.xml
  def create
    @beamer = Beamer.new(params[:beamer])

    respond_to do |format|
      if @beamer.save
        flash[:notice] = 'Beamer was successfully created.'
        format.html { redirect_to(@beamer) }
        format.xml  { render :xml => @beamer, :status => :created, :location => @beamer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @beamer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /beamers/1
  # PUT /beamers/1.xml
  def update
    @beamer = Beamer.find(params[:id])

    respond_to do |format|
      if @beamer.update_attributes(params[:beamer])
        flash[:notice] = 'Beamer was successfully updated.'
        format.html { redirect_to(@beamer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @beamer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /beamers/1
  # DELETE /beamers/1.xml
  def destroy
    @beamer = Beamer.find(params[:id])

    if @mode == :standalone
      @beamer.destroy
    else
      @zone.beamers.delete(@beamer)
      redirect_to @zone
      return false
    end

    respond_to do |format|
      format.html { redirect_to(beamers_url) }
      format.xml  { head :ok }
    end
  end
	
	# Template of activity log file
	# -----------------------------------
	# "DISCOVERY TIMESTAMP:MAC ADDRESS":
	#  - File Name: FILE NAME ON DISK
	#  - Obex Push [Completed|Rejected|Incomplete]: END TIMESTAMP
	#
	# Sample activity log file
	# ----------------------------------
	#
	# "1208029329|00:19:63:51:44:7C":
	#  - File Name: ShrekIIIWallPaper9-2.jpg
	#  - Obex Push Completed: 1208029347
	# "1208029359|00:19:63:51:44:7C":
	#  - File Name: ShrekIIIWallPaper9-8.jpg
	#  - Obex Push Rejected: 1208029367
	# "1208029380|00:19:63:51:44:7C":
	#  - File Name: ShrekIIIWallPaper9-7.jpg
	#  - Obex Push Incomplete: 1208029388
	#
	# ------------------------------------
	def logs
    @beamer = Beamer.find(params[:id])

    nodes  = YAML::load(params[:log].read)
    save   = :success

		nodes.keys.each	{ |key|
			# Step1. Parsing data for each log record
			pos         = key.index('|')
			mac_address = key[pos+1..-1]
			discovery_time	= key[0..pos-1] #timestamp when a discovery occurred

			data      = nodes[key]
			filename  = data[0]["File Name"]
      action_time, action = Beamer.get_action_info(data[1])

			# Step2. Find the campaign-zone tuple from the filename
			#  a. An asset can belong to only one campaign
			#  b. At a given time, there can only be one campaign that is running on
			#     a beamer.
			#  c. But since a beamer can belong to many zones, find which zone 
			#     belongs to the campaign that this asset is part of.
			campaign = zone = nil
			asset    = Asset.find_by_name(filename)
			campaign = asset.campaign unless asset.nil?
			zone     = @beamer.zones.select	{ |z| z.campaigns.include?(campaign) }.first

			# Step3. Creating database records for the parsed log
			#  a. Two Log rows per record: discover & subsequent action
			discovery_record = Log.new(	:phone_mac_add => mac_address, 
																	:timestamp     => Time.at(discovery_time.to_i),
																	:status        => 'discovered',
																	:campaign_id   => campaign.id,
																	:zone_id       => zone.id,
																	:beamer_id     => @beamer.id)

			response_record = Log.new(	:phone_mac_add => mac_address, 
																	:timestamp     => Time.at(action_time),
																	:status        => action,
																	:campaign_id   => campaign.id,
																	:zone_id       => zone.id,
																	:beamer_id     => @beamer.id)

      save = :fail unless discovery_record.save! and response_record.save!
    }

    respond_to do |format|
      format.yaml  {
  		  unless save == :success
          render :text => {'response' => :fail}.to_yaml
          return false
        else
          render :text => {:response => :success}.to_yaml
          return false
  			end
  		}
    end
  end

  def campaigns
    @beamer = Beamer.find(params[:id])
		zones     = @beamer.zones
    campaigns = Array.new
    zones.each {|z| z.campaigns.each {|c| campaigns << c if c.active? } }
    campaigns.uniq!
 
    data = Hash.new
    campaigns.each { |campaign|      
      data[campaign.name] = { :schedules => campaign.schedules.collect {|s|
                                              {:start => s.start,
                                               :end   => s.end,
                                               :interval   => s.interval,
                                               :recurring?  => s.recurring}},
                              :files     => campaign.assets.collect{ |a|
                                              {:name    => a.name,
                                               :purpose => a.purpose,
                                               :type    => a.media,
                                               :url     => a.url}}}
    }
 
    respond_to do |format|
      if data.length > 0
        format.yaml { render :text => data.to_yaml }
      else
        format.yaml { head :ok; return }
      end
    end
  end

end


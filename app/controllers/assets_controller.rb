class AssetsController < ApplicationController
  before_filter :check_and_load_campaign
  
  # GET /assets
  # GET /assets.xml
  def index
	  @assets = @campaign.assets

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assets }
    end
  end

	def download
		@asset = @campaign.assets.find(params[:id])

    respond_to do |format|
 	    format.html { download_link }
 	    format.yaml { download_link }
 	    format.xml  { download_link }
      #format.xml  { render :xml => @asset }
    end
	end

  # GET /assets/1
  # GET /assets/1.xml
  # The show action works like a download
  def show
		@asset = @campaign.assets.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.xml
  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

  # POST /assets
  # POST /assets.xml
  def create
    @asset = Asset.new(params[:asset])
		@asset.campaign_id = params[:campaign_id]

    file_dir          = "#{FILE_STORAGE_PATH}/#{@campaign.id}"
    file_path         = "#{file_dir}/#{@asset.name}"
    rescue_file_path  = "#{FILE_STORAGE_PATH}/#{@asset.name}"

    if !File.exists?(file_dir) and !File.directory?(file_dir)
      Dir.mkdir(file_dir)
      if !File.exists?(file_dir)
        flash[:error] = "Directory #{file_dir} creation failed. Uploading the file to the global storage area."
        file_path = rescue_file_path
      end
    end

    if @asset.save!
		  @asset.path = file_path
		  @asset.url  = FILE_URL_TEMPLATE.sub(':campaign_id', @campaign.id.to_s).sub(':asset_id',@asset.id.to_s)
		  File.open(file_path, "wb") do |f|
			  f.write(params[:asset][:path].read) unless params[:asset][:path].nil?
		  end
    end
    
		respond_to do |format|
    	if @asset.save
        flash[:notice] = "File #{@asset.name} has been successfully added to the campaign #{@campaign.name}."
				format.html { redirect_to(campaign_assets_url([@campaign, @asset])) }
	      format.xml  { render :xml => @asset, :status => :created, :location => @asset }
      else
      	format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
			end
		end	
	end

  # PUT /assets/1
  # PUT /assets/1.xml
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        flash[:notice] = "File #{@asset.name} was successfully updated."
        format.html { redirect_to(campaign_assets_url(@campaign)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.xml
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy()

    respond_to do |format|
      format.html { redirect_to(campaign_assets_url([@campaign, @asset])) }
      format.xml  { head :ok }
    end
  end
	
	def download_link	  
    send_file(@asset.path, :disposition => 'inline', :file_name => @asset.name) if @asset.path	
  end
	
end

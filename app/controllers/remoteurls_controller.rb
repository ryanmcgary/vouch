class RemoteurlsController < ApplicationController                                                     
  before_filter :authenticate_user!, :except => [:index, :new, :create, :edit, :destroy, :update, :show]
  
  # GET /remoteurls
  # GET /remoteurls.xml
  def index
    @site = Site.find(params[:site_id]) 
    @remoteurls = @site.remoteurls
  end

  def show
    @site = Site.find(params[:site_id])
    if @site.remoteurls.find_by_permalink(params[:id]).nil? 
      @remoteurl = @site.remoteurls.build(params[:remoteurl])
      @remoteurl.content = (params[:id])
      respond_to do |format|
        if @remoteurl.save
          format.html { redirect_to "/sites/#{@site.id}/remoteurls/#{@remoteurl.permalink}?layout=embed"}
          format.xml  { render :xml => @site, :status => :created, :location => @remoteurl }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => [@site, @remoteurl].errors, :status => :unprocessable_entity }
        end
      end
    else
    @remoteurl = @site.remoteurls.find_by_permalink(params[:id])
    end 
    
  end

  def new
    @site = Site.find(params[:site_id])  
    @remoteurl = @site.remoteurls.build
  end

  # GET /remoteurls/1/edit
  def edit
    @site = Site.find(params[:site_id])  
    @remoteurl = @site.remoteurls.find_by_permalink(params[:id])
  end

  # POST /remoteurls
  # POST /remoteurls.xml
  def create
    @site = Site.find(params[:site_id])  
    @remoteurl = @site.remoteurls.build(params[:remoteurl])

    respond_to do |format|
      if @remoteurl.save
        format.html { redirect_to([@site, @remoteurl], :notice => 'Remoteurl was successfully created.') }
        format.xml  { render :xml => @site, :status => :created, :location => @remoteurl }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => [@site, @remoteurl].errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /remoteurls/1
  # PUT /remoteurls/1.xml
  def update
    @site = Site.find(params[:site_id])   
    @remoteurl = @site.remoteurls.find_by_permalink(params[:id])

    respond_to do |format|
      if @remoteurl.update_attributes(params[:remoteurl])
        format.html { redirect_to([@site, @remoteurl], :notice => 'Remoteurl was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => [@site, @remoteurl].errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /remoteurls/1
  # DELETE /remoteurls/1.xml
  def destroy
    @site = Site.find(params[:site_id])   
    @remoteurl = @site.remoteurls.find_by_permalink(params[:id])
    @remoteurl.destroy
    
    respond_to do |format| 
      format.html { redirect_to(site_remoteurls_path) }
      format.xml  { head :ok }
    end
  end
end

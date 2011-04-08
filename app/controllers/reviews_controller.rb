class ReviewsController < ApplicationController
  before_filter :set_access_control_headers, :only => [:index]
  
  # GET /reviews
  # GET /reviews.xml
  def index
    @site = Site.find(params[:site_id])
    @remoteurl = @site.remoteurls.find_by_permalink(params[:remoteurl_id]) 
    @reviews = @remoteurl.reviews
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews } 
      format.json  { render :json => @reviews.to_json }
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def new 
    @site = Site.find(params[:site_id])
    @remoteurl = @site.remoteurls.find_by_permalink(params[:remoteurl_id])  
    @review = @remoteurl.reviews.build
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @site = Site.find(params[:site_id])   
    @remoteurl = @site.remoteurls.find_by_permalink(params[:remoteurl_id])  
    @review = @remoteurl.reviews.build(params[:review])

    respond_to do |format|
      if @review.save
        format.html { redirect_to( site_remoteurl_reviews_path , :notice => 'Remoteurl was successfully created.') }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => [@remoteurl, @review].errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to(@review, :notice => 'Review was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to(site_remoteurl_reviews_path) }
      format.xml  { head :ok }
    end
  end
end

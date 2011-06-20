class MastersController < ApplicationController
  # GET /masters
  # GET /masters.xml
  def index
    @masters = Master.find(:all, :include => [:country, :currency, :authority]).paginate :page => params[:page]
    @master = Master.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @masters }
      format.txt
    end
  end

  # GET /masters/1
  # GET /masters/1.xml
  def show
    @master = Master.find(params[:id])
    @note = Note.new( :master => @master ) # for hidden form

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @master }
    end
  end

  # GET /masters/new
  # GET /masters/new.xml
  def new
    @master = Master.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @master }
    end
  end
  
  def search
    @masters = Master.search( params[:q] ).paginate :page => params[:page]
    @master = Master.new

    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @notes }
    end    
  end

  # GET /masters/1/edit
  def edit
    @master = Master.find(params[:id])
  end

  # POST /masters
  # POST /masters.xml
  def create
    @master = Master.new(params[:master])

    respond_to do |format|
      if @master.save
        session[:last_master] = @master.id
        flash[:notice] = "Master '#{@master.name}' was successfully created."
        format.html {  redirect_to :back  }
        format.xml  { render :xml => @master, :status => :created, :location => @master }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @master.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /masters/1
  # PUT /masters/1.xml
  def update
    @master = Master.find(params[:id])

    respond_to do |format|
      if @master.update_attributes(params[:master])
        flash[:notice] = 'Master was successfully updated.'
        format.html { redirect_to(@master) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @master.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /masters/1
  # DELETE /masters/1.xml
  def destroy
    @master = Master.find(params[:id])
    @master.destroy

    respond_to do |format|
      format.html { redirect_to(masters_url) }
      format.xml  { head :ok }
    end
  end
end

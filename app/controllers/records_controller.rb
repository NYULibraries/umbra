class RecordsController < ApplicationController
  # Privileged controller
  before_filter :authenticate_admin
  # Convert blacnk values to nil in params when creating and updating
  before_filter :blank_to_nil_params, :only => [:create, :update]
  respond_to :html, :json

  # GET /records
  # GET /records.json
  def index
    # Generate sunspot search
    @records = record_default_search
  
    respond_with(@records)
  end

  # GET /records/1
  # GET /records/1.json
  def show
    @record = Umbra::Record.find(params[:id])
  
    respond_with(@record)
  end

  # GET /records/new
  # GET /records/new.json
  def new
    @record = Umbra::Record.new

    respond_with(@record)
  end

  # GET /records/1/edit
  def edit
    @record = Umbra::Record.find(params[:id])
  end

  # POST /records
  # POST /records.json
  def create
    @record = Umbra::Record.new(params[:record])

    if @record.save
      flash[:notice] = t("records.create_success")
    end
    respond_with(@record)
  end

  # PUT /records/1
  # PUT /records/1.json
  def update
    @record = Umbra::Record.find(params[:id])
    
    if @record.update_attributes(params[:record])
      flash[:notice] = t("records.update_success")
    end
    
    respond_with(@record)
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record = Umbra::Record.find(params[:id])
    @record.destroy

    respond_with(@record)
  end
  
  # POST /records/update
  def upload
    @records = record_default_search
    csv_file = params[:csv]
    flash[:notice] = Umbra::CsvUpload.new(csv_file, current_user).upload
    
    respond_with(@records) do |format|      
      format.html { render :index }#redirect_to records_url(:notice => flash[:notice]) }
    end
  end

  # Implement sort column function foar Record class
  def sort_column
    super "Umbra::Record", "title_sort"
  end
  helper_method :sort_column

  # Convert blank values to nil values in params
  # Blacklight prints an empty "Field name:" label if the value is blank so this makes sure the values are nil
  def blank_to_nil_params
    params[:record].merge!(params[:record]){|k, v| v.blank? ? nil : v}
  end
  private :blank_to_nil_params
  
  # Default admin search in Sunspot
  def record_default_search
    Umbra::Record.search {
      fulltext params[:q]
      any_of do
        current_user_admin_collections.each { |collection| 
          with(:collection, collection) 
        }
      end
      order_by(sort_column.to_sym, sort_direction.to_sym)
      paginate :page => params[:page] || 1, :per_page => 30
    }
  end
end

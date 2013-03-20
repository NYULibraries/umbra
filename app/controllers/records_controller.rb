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
    @records = Umbra::Record.search {
      fulltext params[:q]
      any_of do
        current_user_admin_collections.each { |collection| 
          with(:collection, collection) 
        }
      end
      order_by(sort_column.to_sym, sort_direction.to_sym)
      paginate :page => params[:page] || 1, :per_page => 30
    }
  
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
      flash[:notice] = "Record was successfully created."
    end
    respond_with(@record)
  end

  # PUT /records/1
  # PUT /records/1.json
  def update
    @record = Umbra::Record.find(params[:id])
    
    if @record.update_attributes(params[:record])
      flash[:notice] ="Record was successfully updated."
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
    csv_file = params[:csv]
    csv_status = Umbra::CsvUpload.new(csv_file, current_user).upload

    # TODO
    # Set flag to indiciate records are batch processing batch_running.pid
    # Launch daemon process to batch insert
    # Use existing CSV code to find or create by original id
    # WHAT KIND OF SECURITY CHECKS DO WE NEED FOR FILE UPLOAD?
    # Only update record if original_id exists and current_user is authroized for collection
    # Figure out way to queue up all records to change and THEN batch update
    # Namespace PID files so you can upload more than one at a time.
    # For user, display an alert box saying "Indexing batched records in background. Please be patient."
    # Have an alert saying "Successfully indexed batched records." based on timestamp on a batch_finished.pid file
    # Have an error saying "Error indexing batched records. Please try again." based on timestamp on a batch_failed.pid file.
    # 
    respond_to do |format|
      flash[:notice] = csv_status
      format.html { redirect_to records_url(:notice => csv_status) }
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
end

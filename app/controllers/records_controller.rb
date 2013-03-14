class RecordsController < ApplicationController
  include Umbra::Collections
  include Umbra::CsvUpload
  # Privileged controller
  before_filter :authenticate_admin
  # Convert blacnk values to nil in params when creating and updating
  before_filter :blank_to_nil_params, :only => [:create, :update]

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
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @records }
    end
  end

  # GET /records/1
  # GET /records/1.json
  def show
    @record = Umbra::Record.find(params[:id])
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record }
    end
  end

  # GET /records/new
  # GET /records/new.json
  def new
    @record = Umbra::Record.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record }
    end
  end

  # GET /records/1/edit
  def edit
    @record = Umbra::Record.find(params[:id])
  end

  # POST /records
  # POST /records.json
  def create
    @record = Umbra::Record.new(params[:record])

    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: "Record was successfully created." }
        format.json { render json: @record, status: :created, location: @record }
      else
        format.html { render action: "new" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /records/1
  # PUT /records/1.json
  def update
    @record = Umbra::Record.find(params[:id])

    respond_to do |format|
      if @record.update_attributes(params[:record])
        format.html { redirect_to @record, notice: "Record was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record = Umbra::Record.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :no_content }
    end
  end
  
  # POST /records/update
  def upload
    csv_file = params[:csv]
    if csv_file.present?
      if is_valid_csv? csv_file
        update_records_from_csv(csv_file)
        flash[:error] = @warning
        flash[:alert] = @alert
      else 
        flash[:error] = "File must be a CSV."
      end
    else
      flash[:error] = "Please select a file to upload."
    end

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
      #flash[:alert] = "Indexing batched records in background. Please be patient."
      #flash[:error] = "Oops! Encountered a problem when indexing batched records. Please try again."
      #flash[:success] = "Successfully index batched records!"
      format.html { redirect_to records_url }
      format.json { head :no_content }
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

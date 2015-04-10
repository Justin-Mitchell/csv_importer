class Admin::CsvImportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_csv_import, only: [:show, :edit, :update, :destroy]

  # GET /csv_imports
  # GET /csv_imports.json
  def index
    @csv_imports = current_user.csv_imports.all
  end

  # GET /csv_imports/1
  # GET /csv_imports/1.json
  def show
  end

  # GET /csv_imports/new
  def new
    @csv_import = current_user.csv_imports.build(key: params[:key])
  end

  # GET /csv_imports/1/edit
  def edit
  end

  # POST /csv_imports
  # POST /csv_imports.json
  def create
    @csv_import = current_user.csv_imports.build(csv_import_params)
    #data = CSV.parse(open(params[:csv_import][:csv].path).read)
    #@csv_import.total_records = data.size - 1
    @csv_import.name = "#{csv_import_params[:source]}-#{csv_import_params[:lead_type]}-#{Time.now.strftime("%B-%d-%Y").downcase}"
    @csv_import.is_temp = false
    
    respond_to do |format|
      if !@csv_import.source.include?('other') && @csv_import.save
        format.html { redirect_to admin_csv_import_path(@csv_import), notice: 'Csv import was successfully created.' }
        format.json { render :show, status: :created, location: @csv_import }
      elsif @csv_import.source.include?('other') && @csv_import.save
        format.html { redirect_to mapping_admin_csv_import_path(@csv_import), notice: 'Csv ready for header mapping.' }
        format.json { render :mapping, status: :ok, location: @csv_import }
      else
        format.html { render :new }
        format.json { render json: @csv_import.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /csv_imports/1
  # PATCH/PUT /csv_imports/1.json
  def update
    respond_to do |format|
      if @csv_import.update(csv_import_params)
        format.html { redirect_to @csv_import, notice: 'Csv import was successfully updated.' }
        format.json { render :show, status: :ok, location: @csv_import }
      else
        format.html { render :edit }
        format.json { render json: @csv_import.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /csv_imports/1
  # DELETE /csv_imports/1.json
  def destroy
    @csv_import.remove_csv!
    @csv_import.destroy
    respond_to do |format|
      format.html { redirect_to admin_csv_imports_path, notice: 'Csv import was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def import
    @csv_import = CsvImport.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_csv_import
      @csv_import = CsvImport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def csv_import_params
      params.require(:csv_import).permit(:source, :name, :csv, :total_records, :new_records_count, :updated_records_count, :is_temp, :csv_processed, :user_id, :lead_type, :key )
    end
end

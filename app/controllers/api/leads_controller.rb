# 'API' Case Consistency
# config/initializers/inflections.rb
module API
  class LeadsController < ApplicationController
    #before_action :authenticate
    
    # GET /leads
    def index
      leads = Lead.all
      if user = params[:user]
        leads = leads.where(:user_id => user)
      end
      
      respond_to do |format|
        format.json { render json: leads, status: :ok }
        format.xml  { render  xml: leads, status: :ok }
      end
    end
    
    def show
      lead = Lead.find(params[:id])
      
      respond_to do |format|
        format.json { render json: lead, status: :ok } #status 200
        format.xml  { render  xml: lead, status: :ok }
      end
    end
    
    def create
      lead = Lead.new(lead_params)
      if lead.save
        head :no_content, location: lead #status 204
      else
        render json: lead.errors, status: :unprocessable_entity #status 422
      end
    end
    
    private
    
      def lead_params
        params.require(:lead).permit(:first_name, :last_name, :email, :kind, :address1, :address2, :city, :state, :zipcode, :source, :category, :company, :phone_mobile, :phone_home, :phone_fax, :phone_work, :birthday, :purchase_date, :budget, :purchase_price, :rating, :home_value, :entry_point, :alt_email, :status, :referred_by, :skype, :facebook, :gchat, :aol, :yahoo, :access, :user_id)
      end
      
      def authenticate
        authenticate_or_request_with_http_basic('Leads') do |email, password|
         User.authenticate(email, password) 
        end
      end
    
  end
end
module Api
  module V1
    class CbsaController  < ApplicationController
      before_action :check_params
      require 'ps_pop_client'
      require 'json'
        
      def find
        render json: PSClient::Api.new.find(request_params)
      end

      private
        def check_params
          rescue ActionController::ParameterMissing
          render_error(:bad_quest, "req parameter is missing!")
        end 
          
        def request_params
          { 
            :cbsa_ids => !strong_params[:cbsa_ids].blank? ?  strong_params[:cbsa_ids].collect{|i| i.to_i } : [],
            :zip_codes => !strong_params[:zip_codes].blank? ? strong_params[:zip_codes].collect{|i| i.to_i } : [],
            :name => strong_params[:name]
          }
        end

        def strong_params
          params.require(:req).permit({:cbsa_ids => []}, {:zip_codes => []}, :name)
        end
    end 
  end
end 
class PatientImportsController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource
	def new
		@patient_import = PatientImport.new
	end

	def create
		@patient_import = PatientImport.new(params[:patient_import])
		if @patient_import.save
			redirect_to patients_path , notice: "Importacion realizada correctamente."
		else
			render :new
		end
	end
end
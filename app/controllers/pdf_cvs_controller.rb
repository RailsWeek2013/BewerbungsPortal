class PdfCvsController < ApplicationController
	require 'fileutils'
	before_action :set_profile, only: [:index, :download, :save]
	before_action :set_school, only: [:index, :download, :save]


	def download
		pdf = index
  		send_data pdf.render, :filename => 'Bewerbung.pdf'
  	end

  	def save 
  		pdf = index
  		#Speichert die PDF in /tmp/prawn.pdf
	    name = "/tmp/Bewerbung" + @profile.name
   	    pdf.render_file(name)
  	end

	private
	def index 

		pdf = Prawn::Document.new(:pages_size => "A4", :size => 16)
		pdf.fill_color "000000"
		pdf.font "Times-Roman"

		pdf.text 	@profile.firstName + " " + @profile.name + " | " + 
	    			@profile.address.street + " | " + 
	    			@profile.address.city + " " + @profile.address.zip + " | " +
	    			"Tel.: " + @profile.telefon 
	    	
	    pdf.draw_text "LEBENSLAUF", :size => 20 , :at => [0,650], :style => :bold

	    pdf.move_down 20
	    pdf.image pic, :at => [450,650], :width => 100 
	    
	    pdf.draw_text "Persönliche Daten" , :at =>[0, 610], :style => :bold

	    pdf.draw_text "Geburtsdatum: ", :at => [0,590]
	    pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [200,590]

	 
		verschieben = 520
		abstand = 15

		pdf.draw_text "Schulbildung", :at => [0, verschieben], :style => :bold
		@schools = current_user.profile.places.where(:type => School)
		verschieben -= abstand
		
		@schools.each do |school|
	    	pdf.draw_text school.time_start.strftime('%d.%m.%Y') + " - " + school.time_end.strftime('%d.%m.%Y') , :at => [0,verschieben]
	    	pdf.draw_text school.desc, :at => [200,verschieben]
	    	verschieben -= abstand
	    end 
	    verschieben -= abstand

		pdf.draw_text "Ausbildung", :at => [0, verschieben], :style => :bold
		verschieben -= abstand	
		@educations = current_user.profile.places.where(:type => Education)
		@educations.each do |education|
			pdf.draw_text education.time_start.strftime('%d.%m.%Y') + " - " + education.time_end.strftime('%d.%m.%Y') , :at => [0,verschieben]
	    	pdf.draw_text education.desc, :at => [200,verschieben]
	    	verschieben -= abstand	
		end
	    verschieben -= abstand

	    pdf.draw_text "Praktische Erfahrung", :at => [0, verschieben], :style => :bold
	    verschieben -= abstand
	    @works = current_user.profile.places.where(:type => Work)
	    @works.each do |work|
	    	pdf.draw_text work.time_start.strftime('%d.%m.%Y') + " - " + work.time_end.strftime('%d.%m.%Y') , :at => [0,verschieben]
	    	pdf.draw_text work.desc, :at => [200,verschieben]
	    	verschieben -= abstand
	    end
	    verschieben -= abstand

	    pdf.draw_text "Kurse", :at => [0, verschieben], :style => :bold
	    verschieben -= abstand
		@courses = current_user.profile.places.where(:type => Course)
		@courses.each do |course|
			pdf.draw_text course.time_start.strftime('%d.%m.%Y') + " - " + course.time_end.strftime('%d.%m.%Y') , :at => [0,verschieben]
	    	pdf.draw_text course.desc, :at => [200,verschieben]
	    	verschieben -= abstand	
		end
	    verschieben -= abstand

	    pdf.draw_text "Besondere Kenntnisse", :at => [0, verschieben], :style => :bold
	    verschieben -= abstand
	 	@knowledges = current_user.profile.knowledges.all
	 	@knowledges.each do |knowledge|
	 		pdf.draw_text knowledge.name, :at => [0,verschieben] 
        	pdf.draw_text knowledge.desc, :at => [200,verschieben]
        	verschieben -= abstand	
        end  
	    verschieben -= abstand	


		pdf.draw_text @profile.address.city + ", " + Time.now.strftime('%d.%m.%Y')	, :at => [0,80]

	    pdf.draw_text @profile.firstName + " " + @profile.name , :at => [0,50]

		pdf.image sig,  :at => [0,10],  :width => 50

		return pdf
   	end

   	

   	private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firstName, :name, :birthday, :address_id, :marialStatus, :telefon, :avatar,address_attributes: [:profile_id,:street,:city,:zip,:id])
    end

    def sig
		image = Rails.root.to_s+"/public"+@profile.signature.url(:original)
	    image = image.strip
	    img = image.split('?')
	    return img[0]
	end

	def pic
		image = Rails.root.to_s+"/public"+@profile.avatar.url(:original)
	    image = image.strip
	    img = image.split('?')
	    return img[0]
	end
end

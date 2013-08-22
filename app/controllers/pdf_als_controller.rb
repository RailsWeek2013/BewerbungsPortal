class PdfAlsController < ApplicationController
 require 'fileutils'

	before_action :set_profile, only: [:index, :download, :save]
	before_action :set_school, only: [:index, :download, :save]
	before_action :set_loa, only: [:index, :download, :save]

	def download
		pdf = index
  		send_data pdf.render, :filename => 'Bewerbungsanschreiben.pdf'
  	end

  	def save 
  		pdf = index
  		#Speichert die PDF in /tmp/prawn.pdf
	    name = "/tmp/Bewerbungsanschreiben" + @profile.name
   	    pdf.render_file(name)
   	    #Bewerbungsanschreiben
   	    Notification.send_cv(@profile, name).deliver
  	end

	private
  	def index

  		pdf = Prawn::Document.new(:pages_size => "A4", :size => 16)
	    zeilenabstand = 20
	    pdf.fill_color "000000"
	    pdf.font "Times-Roman"    
	    
	    # Anschrift des Bewerbers
	    pdf.text_box 	@profile.firstName + " " + @profile.name + "\n" + 
	    				@profile.address.street + "\n" +
	    				@profile.address.city + " " + @profile.address.zip + "\n" +
	    				"Tel.: " + @profile.telefon, :at => [0,730] , :height => 50, :width => 350  
	    
	    #pdf.move_down zeilenabstand

	    # Bild des Bewerbers
	    pdf.image pic, :at => [450,730], :width => 80, :height => 120

	    # Anschrift des Unternehmen
		pdf.text_box 	@loa.to + "\n" +					
						@loa.street	+ "\n" +
						@loa.city + " " + @loa.zip, :at => [0,650] , :height => 50, :width => 300 		

		# Ort und Dartum
		pdf.draw_text @profile.address.city + ", " + Time.now.strftime('%d.%m.%Y')	, :at => [400,600]

		# Betreff des Anschreibens
		pdf.text_box @loa.subject, :at => [0, 550], :height => 40, :width => 500				
		
		# Name es Anzuschreibenen
		pdf.draw_text "Sehr geehrte Damen und Herren,", :at => [0, 520] 
		
		# Das Bewerbungsanschreiben
		pdf.text_box @loa.what	 , :at => [0, 500], :height => 300, :width => 550
		
		pdf.move_down 350


		pdf.draw_text "Mit freundlichen Grüßen", :at => [0, 150] 
		
		pdf.draw_text @profile.firstName + " " + @profile.name , :at => [0,100]

		# Unterschrift
		pdf.image sig,  :at => [0,50],  :width => 50

		return pdf

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    #def set_place
     # @place = Place.find(params[:id])
   # end

    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firstName, :name, :birthday, :address_id, :marialStatus, :telefon, :avatar,address_attributes: [:profile_id,:street,:city,:zip,:id])
    end

	def pic
		image = Rails.root.to_s+"/public"+@profile.avatar.url(:original)
	    image = image.strip
	    img = image.split('?')
	    return img[0]
	end

	def sig
		image = Rails.root.to_s+"/public"+@profile.signature.url(:original)
	    image = image.strip
	    img = image.split('?')
	    return img[0]
	end

	# Use callbacks to share common setup or constraints between actions.
    def set_loa
      @loa = Loa.find(params[:id])
    end

end

class PdfAlsController < ApplicationController
 require 'fileutils'

	before_action :set_profile, only: [:index]
	before_action :set_school, only: [:index]
	before_action :set_loa, only: [:index]


  def index

  	pdf = Prawn::Document.new(:pages_size => "A4", :size => 16)
	    zeilenabstand = 20
	    pdf.fill_color "000000"
	    pdf.font "Times-Roman"    
	    
	    # Anschrift des Bewerbers
	    pdf.text @profile.firstName + " " + @profile.name
	    pdf.text @profile.address.street
	    pdf.text @profile.address.city + " " + @profile.address.zip
	    pdf.text "Tel.: " + @profile.telefon
	    
	    pdf.move_down zeilenabstand

	    # Bild des Bewerbers
	    pdf.image pic, :at => [450,700], :width => 100 

	    # Anschrift des Unternehmen
		pdf.text @loa.to					
		pdf.text @loa.street	
		pdf.text @loa.city + " " + @loa.zip 		

		pdf.move_down zeilenabstand

		# Ort und Dartum
		pdf.draw_text @profile.address.city + ", " + Time.now.strftime('%d.%m.%Y')	, :at => [400,550]
		
		pdf.move_down zeilenabstand

		# Betreff des Anschreibens
		pdf.text @loa.subject				

		pdf.move_down zeilenabstand
		
		# Name es Anzuschreibenen
		pdf.text "Sehr geehrte Damen und Herren," 
		
		pdf.move_down zeilenabstand

		# Das Bewerbungsanschreiben
		pdf.text_box @loa.what	 , :at => [0, 500], :height => 300, :width => 550
		
		pdf.move_down 350


		pdf.text "Mit freundlichen Grüßen" 

		pdf.move_down zeilenabstand
		
		pdf.text @profile.firstName + " " + @profile.name #, :at => [0,100]

		pdf.move_down zeilenabstand

		# Unterschrift
		pdf.image sig,  :at => [0,50],  :width => 50


		send_data pdf.render, :filename => 'Bewerbung.pdf'


	    #Speichert die PDF in /tmp/prawn.pdf
	    #name = "/tmp/Bewerbungsanschreiben" + @profile.name
   	    #pdf.render_file(name)
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

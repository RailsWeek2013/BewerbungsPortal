class PdfAlsController < ApplicationController
 require 'fileutils'

	before_action :set_profile, only: [:index]
	before_action :set_school, only: [:index]

  def index

  	pdf = Prawn::Document.new(:pages_size => "A4", :size => 16)
	    zeilenabstand = 20
	    pdf.fill_color "000000"
	    pdf.font "Times-Roman"    
	    
	    pdf.text @profile.firstName + " " + @profile.name
	    #pdf.move_down zeilenabstand
	    pdf.text @profile.address.street
	    #pdf.move_down zeilenabstand
	    pdf.text @profile.address.city + " " + @profile.address.zip
	    #pdf.move_down zeilenabstand
	    pdf.text "Tel.: " + @profile.telefon
	    
	    pdf.move_down zeilenabstand
	    
	    

	    
	    #pdf.text Rails.root.to_s+@profile.avatar.url(:original) 
	    #FileUtils.mv( @profile.avatar.url(:original), '/tmp')
	    pdf.image pic, :at => [450,700], :width => 100 #@profile.avatar.url(:medium)
		#pdf.image @profile.avatar.url(:original) , :at => [450,700], :width => 100 #@profile.avatar.url(:medium)

		pdf.text "THM"					#, :at => [0,550]
		pdf.text "-Studiensekretarit"	#, :at => [0,530]
		pdf.text "Wiesenstr. 14"		#, :at => [0,510]
		pdf.text "35390 Gießen"			#, :at => [0,490]

		pdf.move_down zeilenabstand

		pdf.draw_text @profile.address.city + ", " + Time.now.strftime('%d.%m.%Y')	, :at => [400,550]
		
		pdf.move_down zeilenabstand

		pdf.text "BETREFF"				#, :at => [0,400]

		pdf.move_down zeilenabstand
		
		# Name es Anzuschreibenen
		if @profile.firstName == nil
			pdf.text "Sehr geehrte Damen und Herren," #, :at => [0,380]
		else
			pdf.text "Sehr geehrter Herr " + @profile.firstName
		end

		pdf.move_down zeilenabstand

		text = "Test testtest testtesttest  " * 1000
		pdf.text_box text	 , :at => [0, 500], :height => 300, :width => 550
		
		pdf.move_down 350

		pdf.text "Mit freundlichen Grüßen" #, :at => [0, 150]

		pdf.move_down zeilenabstand
		
		pdf.text @profile.firstName + " " + @profile.name #, :at => [0,100]

		pdf.move_down zeilenabstand

		pdf.image "/tmp/unterschrift.png",  :at => [0,50],  :width => 50

		send_data pdf.render, :filename => 'Bewerbungsanschreiben.pdf'


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

	def pic
		image = Rails.root.to_s+"/public"+@profile.avatar.url(:original)
	    image = image.strip
	    img = image.split('?')
	    return img[0]
	end

end

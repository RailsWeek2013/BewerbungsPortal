class PdfController < ApplicationController
	before_action :set_profile, only: [:index]

	def index
  		
		#text = "einfacher text"
    	#pigs = "#{Prawn::BASEDIR}/asserts/images/index.jpeg" 
    	#pigs = "/tmp/index.jpeg"
    	#puts pigs
    	#pdf.image pigs
    	#pdf.image "http://prawn.majesticseacreature.com/media/prawn_logo.png" , :at => [300,300], :width => 40
    	#pdf.image open("http://www.klaus-dodemont.de/2004.11.20-Wandbild_Finanzamt__2_.JPG")

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
	    
	    pdf.image "/tmp/GNU.png", :at => [450,700], :width => 100 #@profile.avatar.url(:medium)
	
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

	    
		#-------------------------------------------------------------------------
	    pdf.start_new_page
	    
	    pdf.text 	@profile.firstName + " " + @profile.name + " | " + 
	    				@profile.address.street + " | " + 
	    				@profile.address.city + " " + @profile.address.zip + " | " +
	    				"Tel.: " + @profile.telefon #, :at => [0,640], :at => [0, 700]
	    
					
	    pdf.draw_text "LEBENSLAUF", :size => 20 , :at => [0,650], :style => :bold

	    pdf.move_down zeilenabstand
	    pdf.image "/tmp/GNU.png", :at => [450,650], :width => 100 #@profile.avatar.url(:medium)
	    
	    pdf.draw_text "Persönliche Daten" , :at =>[0, 610], :style => :bold
	    #pdf.horizontal_line 25, 100, :at => 75

	    pdf.draw_text "Geburtsdatum: ", :at => [0,590]
	    pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [200,590]

	 

		pdf.draw_text "Schulbildung", :at => [0, 520], :style => :bold

	    pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [0,500]
	    pdf.draw_text "Schule A", :at => [200,500]

		pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [0,480]
	    pdf.draw_text "Schule B", :at => [200,480]

	    pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [0,460]
	    pdf.draw_text "Schule C", :at => [200,460]

	    pdf.draw_text "Praktische Erfahrung", :at => [0, 400], :style => :bold

		pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [0,380]
	    pdf.draw_text "Schule A", :at => [200,380]

		pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [0,360]
	    pdf.draw_text "Schule B", :at => [200,360]

	    pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [0,340]
	    pdf.draw_text "Schule C", :at => [200,340]

	    pdf.draw_text "Besondere Kenntnisse", :at => [0, 300], :style => :bold

		pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [0,280]
	    pdf.draw_text "Schule A", :at => [200,280]

		pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [0,260]
	    pdf.draw_text "Schule B", :at => [200,260]

	    pdf.draw_text @profile.birthday.strftime('%d.%m.%Y'), :at => [0,240]
	    pdf.draw_text "Schule C", :at => [200,240]

	    pdf.draw_text "Besondere Kenntnisse", :at => [0, 200], :style => :bold
	    pdf. draw_text "Dies und das", :at => [0, 180]


		pdf.draw_text @profile.address.city + ", " + Time.now.strftime('%d.%m.%Y')	, :at => [0,130]

	    pdf.draw_text @profile.firstName + " " + @profile.name , :at => [0,100]

		pdf.image "/tmp/unterschrift.png",  :at => [0,50],  :width => 50


	     
	    send_data pdf.render, :filename => 'Bewerbungsanschreiben.pdf'
  	end

  	private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firstName, :name, :birthday, :address_id, :marialStatus, :telefon, :avatar,address_attributes: [:profile_id,:street,:city,:zip,:id])
    end
end

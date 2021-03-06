class PdfsController < ApplicationController
	before_action :set_profile, only: [ :download_all, :save_all, :save_cvs, :download_als, :download_cvs, :save_al, :save_cvs]
	before_action :set_school, only: [ :download_all, :save_all, :download_als, :download_cvs, :save_al, :save_cvs]
	before_action :set_loa, only: [ :download_all, :save_all, :download_als, :download_cvs, :save_al, :save_cvs]

	def download_als
		pdf = pdf_generate
		pdf = pdf_als pdf
		send_data pdf.render, :filename => 'Bewerbungsanschreiben.pdf'
	end

	def download_cvs
		pdf = pdf_generate
		pdf_cvs pdf
		send_data pdf.render, :filename => 'Lebenslauf.pdf'
	end

	def download_all
		pdf = pdf_all_generate
		send_data pdf.render, :filename => 'BewerbungsanschreibenUndLebenslauf.pdf'
	end

	def save_al
		pdf = pdf_generate
		pdf = pdf_als pdf
		#Speichert die PDF in /tmp/Bewerbungsschreiben.pdf
	    name = "/tmp/BewerbungsanschreibenVon" + @profile.name
   	    pdf_save name,pdf 
	end

	def save_cvs
		pdf = pdf_generate
		pdf = pdf_cvs pdf
		#Speichert die PDF in /tmp/Bewerbungsschreiben.pdf
	    name = "/tmp/LebenslaufVon" + @profile.name
   	    pdf_save name,pdf 
	end

	

	def save_all
		pdf = pdf_all_generate
  		#Speichert die PDF in /tmp/Bewerbungsschreiben.pdf
	    name = "/tmp/BewerbungsanschreibenUndLebenslaufVon" + @profile.name
   	    pdf_save name,pdf 
	end



private
	def pdf_save name,pdf
   	    pdf.render_file(name)
   	    #Bewerbung
   	    Notification.send_cv(@profile, name).deliver
	end


	def pdf_generate
		pdf = Prawn::Document.new(:pages_size => "A4", :size => 16)
		pdf.fill_color "000000"
		pdf.font "Times-Roman"
		return pdf
	end

	def pdf_all_generate
		pdf = pdf_generate
		pdf = pdf_als pdf
		pdf.start_new_page
		pdf = pdf_cvs pdf
		return pdf
	end
	

	
	def pdf_als pdf
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

	def pdf_cvs pdf
		#pdf = Prawn::Document.new(:pages_size => "A4", :size => 16)
		

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
		abstand = 13

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

	# Use callbacks to share common setup or constraints between actions.
    def set_profile
    	if Profile.count == 0
    		@profile = " "
    	else
			@profile = Profile.find(params[:id])
		end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_place
    	if Place.count == 0
    		@place = " "
    	else
      		@place = Place.find(params[:id])
      	end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_school
    	if School.count == 0 
    		@school = " "
    	else
      		@school = School.find(params[:id])
      	end
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
      @loa = @profile.loa
    end


end

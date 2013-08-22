# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'ilja.michajlow@mni.thm.de', password: 'foobar123', password_confirmation: 'foobar123')

profile = Profile.create(firstName: "Max", name: "Mustermann", birthday: "2013-08-20", marialStatus: "ledig", telefon: "123456", user_id: user.id)

Address.create(street: "Muster Street", zip: "123456", city: "Muster City", profile_id: profile.id)

puts "Insert Places-School"
School.create(time_start: Date.parse("1970-09-01"), time_end: Date.parse("1983-09-01"), desc: "Alexander-von-Humboldt Gymnasium, Berlin", type: "School", profile_id: profile.id)

puts "Insert Places-Education"
Education.create(time_start: Date.parse("1984-01-01"), time_end: Date.parse("1989-08-20"), desc: "THM Friedberg Informatik-Student", type: "Education", profile_id: profile.id)

puts "Insert Places-Work"
Work.create(time_start: Date.parse("1990-08-20"), time_end: Date.parse("1991-08-20"), desc: "McDonalds Mitarbeiter", type: "Work", profile_id: profile.id)
Work.create(time_start: Date.parse("1992-08-20"), time_end: Date.parse("1995-08-20"), desc: "Tafel putzen", type: "Work", profile_id: profile.id)
Work.create(time_start: Date.parse("1996-08-20"), time_end: Date.parse("2013-08-20"), desc: "Microsoft Corporation Der Boss", type: "Work", profile_id: profile.id)

puts "Insert Places-Course"
Course.create(time_start: Date.parse("2005-08-20"), time_end: Date.parse("2005-09-20"), desc: "C#", type: "Course", profile_id: profile.id)
Course.create(time_start: Date.parse("2007-08-20"), time_end: Date.parse("2007-10-20"), desc: "Java", type: "Course", profile_id: profile.id)
Course.create(time_start: Date.parse("2013-08-20"), time_end: Date.parse("2013-08-20"), desc: "Ruby On Rails", type: "Course", profile_id: profile.id)

puts "Insert Knowledges"

Knowledge.create(name: "Sprachen:", desc: "Englisch, Deutsch, Russisch, Spanisch", profile_id: profile.id)


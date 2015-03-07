require "sinatra"
require "json"
require "sqlite3"
require "pry"

DATABASE = SQLite3::Database.new("slideshow.db")
DATABASE.results_as_hash = true
DATABASE.execute("CREATE TABLE IF NOT EXISTS slides (id INTEGER PRIMARY KEY,
                  place INTEGER, title TEXT, body TEXT)")

require_relative "slide"

# binding.pry

get "/" do
  erb :home
end


get "/start_slideshow" do
  slide = Slide.find(0)

  slide_hash = slide.to_hash

  slide_hash.to_json
end

get "/get_slide/:place" do
  slide = Slide.find(params[:place])

  slide_hash = slide.to_hash

  slide_hash.to_json
end


# get "/students/can_drink/:id" do
#   student = Student.find(params[:id])
#   student_hash = student.to_hash
#   student_hash["can_drink"] = student.can_drink?
#   student_hash.to_json
# end
#
#
# get "/students/ultra_wise/:id" do
#   student = Student.find(params[:id])
#   student_hash = student.to_hash
#   student_hash["ultra_wise"] = student.ultra_wise?
#   student_hash.to_json
# end
#
#
# get "/students/edit" do #/id/:id/name/:name/age/:age/github/:github" do
#
#   student = Student.find(params[:id])
#
#   student.name = params[:name]
#   student.age = params[:age]
#   student.github = params[:github]
#
#   student.save
#
#   student_hash = student.to_hash
#   student_hash.to_json
# end
#
#
# post "/students/new" do #/name/:name/age/:age/github/:github" do
#   binding.pry
#   student = Student.new({"name"=>params[:name],"age"=>params[:age],"github"=>params[:github]})
#   student.insert
#
#   students = Student.all
#
#   students_hash = students.map {|s| s.to_hash}
#   students_hash.to_json
# end
#
#
#
# get "/students/:id" do
#   student = Student.find(params[:id])
#
#   student_hash = student.to_hash
#   student_hash.to_json
# end
#
#
# get "/students/delete/id/:id" do
#   student = Student.find(params[:id])
#   student.delete
#
#   students = Student.all
#
#   students_hash = students.map {|s| s.to_hash}
#   students_hash.to_json
# end
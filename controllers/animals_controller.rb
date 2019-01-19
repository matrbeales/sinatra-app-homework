class AnimalsController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }


  # Index
  get "/" do
    @animals = Animal.all
    erb :"animals/index.html"
  end

  # New
  get "/new" do
    @animal = Animal.new
    erb :"animals/new.html"
  end

  # Show
  get "/:id" do
    id = params[:id].to_i
    @animal = Animal.find id
    erb :"animals/show.html"
  end

  # Edit
  get "/:id/edit" do
    id = params[:id].to_i
    @animals = Animal.find id
    erb :"animals/edit.html"
  end

  # Create
  post "/" do
    animal = Animal.new
    animal.animal_name = params[:animal_name]
    animal.latin_name = params[:latin_name]
    animal.description = params[:description]

    animal.save
    redirect "/"
  end

  # Update
  put "/:id" do
    id = params[:id].to_i
    animal = Animal.find id

    animal.animal_name = params[:animal_name]
    animal.latin_name = params[:latin_name]
    animal.description = params[:description]

    animal.save

    redirect "/#{id}"
  end

  # Destroy
  delete "/:id" do
    id = params[:id].to_i
    Animal.destroy id

    redirect "/"
  end
end

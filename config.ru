require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development?
require_relative "controllers/animals_controller.rb"
require_relative "models/animal.rb"

use Rack::MethodOverride
run AnimalsController

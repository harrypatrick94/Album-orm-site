require 'sinatra' # require sinatra
require 'sinatra/reloader' #auto relaod
require 'sqlite3'  # to talk to our SQL database
require 'pry' #debgguer
require 'active_record' #sqlite3 library
# to start ruby server with active active_record
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3', # What is the db system we are using?
  database: 'database.db' # Where is the actual DB database
)

# Log of the sql queries contrustructed by ActiveRecord
ActiveRecord::Base.logger = Logger.new STDERR

# close connection after each block has been run
after do
  ActiveRecord::Base.connection.close
end

class Artist < ActiveRecord::Base
  # tell active record who is the has hany
  has_many :albums
end


class Album < ActiveRecord::Base
  # assumes animal_id is defined in the spotters table
  belongs_to :artist

end

# dry up code by creating a reuseable DB query function
def db_query sql

    db = SQLite3::Database.new 'database.db'
    db.results_as_hash = true
    # debugging output in the terminal:
    puts '================='
    puts sql
    puts '================='
    results db.execute sql
    db.close might

    results # return results as query
end

get '/' do
  erb :home
end

get '/bands/new' do
  erb :new
end

# create new bands
post '/bands' do

  Artist.create(
    name: params[:name],
    formed: params[:formed],
    together: params[:together],
    photo: params[:photo]
  )

  redirect '/bands'
end


# 1. Index of all animals in table
get '/bands' do

  @results = Artist.all
  # binding.pry
  erb :index
end

# 2. Show band infomation

get '/bands/:id' do

  @band = Artist.find params[:id]
  erb :show
end

# 1. show edit form
get '/bands/:id/edit' do
  @band = Artist.find params[:id]

  erb :edit
end

# 2. Submit form and update row

post '/bands/:id' do
  # binding.pry

  band = Artist.find params[:id]
  band.update(
    name: params[:name],
    together: params[:together],
    photo: params[:photo]
  )

  redirect "/bands/#{ params[:id] }"
end


# 2. Submit form and update row


get "/bands/:id/delete" do

  Artist.destroy params[:id]

  redirect "/bands"
end

# get "/bands/:id/delete/:album_id" do
#
#   Album.destroy params[:album_id]
#
#   redirect "/bands"
# end
# Albums

# Add album
get '/bands/new/album' do

  erb :album_edit
end

post '/bands/:id' do
  # binding.pry
  Album.create(
    name: params[:name],
    year: params[:year],
    artist_id: params[:artist_id]
  )

  redirect "/bands/#{ params[:artist_id] }"
end

# Show album

get '/bands/:id/:artist_id' do

  @band = Artist.find params[:id]
  @album = Album.find params[:id]

  erb :show_album
end

# require_relative 'rolodex'
# require_relative 'contact'
require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'logger'

# configure :development do
#   set :logging, Logger::DEBUG
# end

before do
  puts "-"*50
  puts "PARAMS: #{params}"
end

DataMapper.setup(:default, 'sqlite3:database.sqlite3')

class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :notes, String

	# attr_accessor :id, :first_name, :last_name, :email, :notes

	DataMapper.finalize
	DataMapper.auto_upgrade!

	def to_s
		"#{first_name}, #{last_name}, #{email}, #{notes}"
	end
end


# Class Contact
# include DataMapper::Resource
# end


# $rolodex= Rolodex.new 

# $rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))



get '/' do 
	@crm_app_name = "Nancy Wood's CRM"
	erb :index  
end

get '/contacts' do
	# @contacts = []
	# @contacts << Contact.new("Mike", "Fich", "mike@fich.com", "cool guy")
	# @contacts << Contact.new("Rhea", "Really", "rhea@really.com", "cool gal")
	# @contacts << Contact.new("Keegan", "Dude", "keegan@dude.com", "the dude")
	# @contacts << Contact.new("Nancy", "Wood", "nancy@librarian.com", "the librarian")

	@contacts = Contact.all

	erb :contacts
	# - find contacts.erb
	# - is there layout.erb
	# 	- start rendering layout.erb
	# 		-when we get yield
	# 			-start rendering contacts.erb
	# 	-finish rendering layout.erb
	# - send it to the user
end

get '/contacts/new' do	
	erb :new_contact
end

get "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end




get "/contacts/:id/edit" do
	  @contact = Contact.get(params[:id].to_i)

	  if @contact
	    erb :edit_contact
	  else
	    raise Sinatra::NotFound
	  end
end


put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.notes = params[:notes]
    @contact.save
    redirect to("/contacts/#{@contact.id}")
  else
    raise Sinatra::NotFound
  end
end





get "/contacts/:id/delete" do
    @contact = Contact.get(params[:id].to_i)
    if @contact
      erb :delete_contact
    else
      raise Sinatra::NotFound
    end
end

delete "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy 
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end





# post '/contacts' do
#   new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
#   $rolodex.add_contact(new_contact)
#   redirect to('/contacts')
# end

get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

post "/contacts" do
  contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :notes => params[:notes]
  )
  redirect to('/contacts')
end


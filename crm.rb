require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
require 'sinatra/reloader'

# DataMapper.setup(:default, 'sqlite:crm_development.sqlite')

# Class Contact
# include DataMapper::Resource
# end


$rolodex= Rolodex.new 

$rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))



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

get "/contacts/1000" do
  @contact = $rolodex.find(1000)
  erb :show_contact
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end


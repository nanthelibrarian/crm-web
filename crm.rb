require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex= Rolodex.new 

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
end

get '/contacts/new' do	
	erb :new_contact
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end
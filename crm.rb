require_relative 'contact'
require 'sinatra'

get '/' do 
	@crm_app_name = "Nancy Wood's CRM"
	erb :index  
end

get '/contacts' do
	@contacts = []
	@contacts << Contact.new("Mike", "Fich", "mike@fich.com", "cool guy")
	@contacts << Contact.new("Rhea", "Really", "rhea@really.com", "cool gal")
	@contacts << Contact.new("Keegan", "Dude", "keegan@dude.com", "the dude")
	@contacts << Contact.new("Nancy", "Wood", "nancy@librarian.com", "the librarian")

	erb :contacts
end

get '/add_contacts' do	
	erb :add_contacts
end

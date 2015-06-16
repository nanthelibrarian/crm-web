require 'sinatra'

get '/' do 
	@crm_app_name = "Nancy Wood's CRM"
	erb :index  
end

get '/contacts' do
	erb :contacts
end

get '/add_contacts' do	
	erb :add_contacts
end


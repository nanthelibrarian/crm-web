require 'sinatra'

get '/' do 
	@crm_app_name = "Nancy Wood's CRM"
	erb :index 
end

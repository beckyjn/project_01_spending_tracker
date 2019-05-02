require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('../models/tag.rb')


get '/spending-tracker/tags' do #index
  @month = nil
  @tags = Tag.all
  erb(:"tags/index")
end

get '/spending-tracker/tags/find' do #index
  @tags = Tag.all
  @month = params['month'] ? params['month'] : ""
  @year = params['year'] ? params['year'] : ""
  erb(:"tags/index")
end

get '/spending-tracker/tags/new' do #new
  erb(:"tags/new")
end

post '/spending-tracker/tags' do #create
  @tag = Tag.new(params)
  @tag.save
  erb(:"tags/create")
end

get '/spending-tracker/tags/:id' do #show
  @tag = Tag.find(params[:id])
  erb(:"tags/show")
end

get '/spending-tracker/tags/:id/edit' do #edit
  @tag = Tag.find(params[:id])
  erb(:"tags/edit")
end

post '/spending-tracker/tags/:id' do #update
  Tag.new( params ).update
  redirect to("/spending-tracker/tags")
end

post '/spending-tracker/tags/:id/delete' do #destroy
  tag = Tag.find(params[:id])
  tag.delete
  redirect to("/spending-tracker/tags")
end

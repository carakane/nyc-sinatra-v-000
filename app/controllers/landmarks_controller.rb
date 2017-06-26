class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    @figures = Figure.all
    @titles = Title.all
    erb :'/landmarks/new'
  end

  post '/landmarks/new' do
    @landmark = Landmark.create(:name => params["landmark"]["name"], :year_completed => params["landmark"]["year_completed"])

    if params["landmark"]["figure_ids"]
      @figure = Figure.find_by(:id => params["landmark"]["figure_ids"])
      @figure.landmarks << @figure
      @figure.save
      @landmark.save
    elsif params["figure"]["name"]
      @figure = Figure.create(:name => params["figure"]["name"])
      @figure.landmarks << @landmark
      @figure.save
      @landmark.save
    end
    erb :'/landmarks/show'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(:id => params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by(:id => params[:id])
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by(:id => params[:id])
    if @landmark.name != params["landmark"]["name"]
      @landmark.update(:name => params["landmark"]["name"])
    end
    if @landmark.year_completed != params["landmark"]["year_completed"]
      @landmark.update(:year_completed => params["landmark"]["year_completed"])
    end
    erb :'/landmarks/show'
  end

end

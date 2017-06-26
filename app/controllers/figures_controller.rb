class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by(:id => params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(:id => params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  post '/figures/new' do
    @figure = Figure.create(:name => params["figure"]["name"])
    @figure_title = FigureTitle.create(:figure_id => @figure.id)

    if params["title"]["name"] == "" && params["figure"]["title_ids"]
      @title = Title.find_by(:id => params["figure"]["title_ids"])
      @figure.titles << @title
      @figure_title.title_id = @title.id
    elsif params["title"]["name"]
      @title = Title.create(:name => params["title"]["name"])
      @figure.titles << @title
      @figure_title.title_id = @title.id
    end

    if params["landmark"]["name"] == "" && params["figure"]["landmark_ids"]
      @landmark = Landmark.find_by(:id => params["figure"]["landmark_ids"])
      @figure.landmarks << @landmark
      @landmark.figure_id = @figure.id
    elsif params["landmark"]["name"]
      @landmark = Landmark.create(:name => params["landmark"]["name"])
      @figure.landmarks << @landmark
      @landmark.figure_id = @figure.id
    end

    @figure.save
    @figure_title.save
    erb :'/figures/show'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by(:id => params[:id])
    @figure_title = FigureTitle.find_by(:figure_id => @figure.id)

    if @figure.name != params["figure"]["name"]
      @figure.update(:name => params["figure"]["name"])
    end

    if params["title"]["name"] == "" && params["figure"]["title_ids"]
      @title = Title.find_by(:id => params["figure"]["title_ids"])
      @figure.titles << @title
      @figure_title.title_id = @title.id
    elsif params["title"]["name"]
      @title = Title.create(:name => params["title"]["name"])
      @figure.titles << @title
      @figure_title.title_id = @title.id
    end

    if params["landmark"]["name"] == "" && params["figure"]["landmark_ids"]
      @landmark = Landmark.find_by(:id => params["figure"]["landmark_ids"])
      @figure.landmarks << @landmark
      @landmark.figure_id = @figure.id
    elsif params["landmark"]["name"]
      @landmark = Landmark.create(:name => params["landmark"]["name"])
      @figure.landmarks << @landmark
      @landmark.figure_id = @figure.id
    end

    @figure.save
    @figure_title.save
    erb :'/figures/show'
  end

end

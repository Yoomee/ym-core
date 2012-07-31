class RedactorUploadsController < ApplicationController
  
  def create
    @redactor_upload = RedactorUpload.create(:image => params[:file])
    render :json => {:filelink => @redactor_upload.image.url}
  end
  
  def index
    render :json => RedactorUpload.all.collect{|ru| {:image => ru.image.url, :thumb => ru.image.thumb('110x80#').url}}
  end
  
end
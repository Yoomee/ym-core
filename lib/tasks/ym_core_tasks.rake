desc "Download all images managed by Dragonfly"
task :download_images => :environment do
  all_models = Dir['**/models/**/*.rb'].map {|f| File.basename(f, '.*').camelize.constantize }
  all_models.each do |model|
    if model.respond_to?(:dragonfly_attachment_classes) && model.dragonfly_attachment_classes.present?
      model.find_each do |resource|
        resource.dragonfly_attachments.each do |image_method,attachment|
          image = resource.send(image_method)
          YmCore::ImageDownloader.download_image_if_missing(image) if image
        end
      end 
    end
  end
end
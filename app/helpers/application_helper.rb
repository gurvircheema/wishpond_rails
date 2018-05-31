module ApplicationHelper
  def url_array(images)
    hsh = {}
    images.each_with_index do |image, index|
      hsh[index] = rails_blob_url(image)
    end
    hsh.to_json
  end
end

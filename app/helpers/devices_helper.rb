module DevicesHelper
  def dev_paths_datalist
    content_tag 'datalist', id: :dev_paths do
      options_for_select Device.dev_paths.sort
    end
  end
end

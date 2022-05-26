module ApplicationHelper

  # Map flash error types to specific bs classes
  FLASH_CLASS = {
    notice: 'secondary',
    alert: 'warning',
    error: 'danger',
    success: 'success'
  }

  def flash_messages(flash)
    return if flash.blank?

    flash.map do |type, msg| 
      content_tag :div, class: "alert alert-#{FLASH_CLASS[type.to_sym]} alert-dismissible fade show" do
        concat msg
        concat button_tag('', class: 'btn-close', data: { 'bs-dismiss': 'alert' } )
      end
    end.join
  end

  def logo
    content_tag :h3 do 
      content_tag :strong do
        "Trustbin"
      end           
    end
  end
end



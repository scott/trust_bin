module ApplicationHelper

  include Pagy::Frontend
  
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
      concat image_tag('logo.png', style: 'width: 35px; height: 35px; margin-right: 10px;')
      concat content_tag(:strong, "Trustb.in")
    end
  end

  # 
  # Shows either the time go in words, or the date, depending on
  # how long ago it was
  def time_ago(time_to_check)
    diff = distance_of_time_in(:days, Time.now, time_to_check)
    if diff <= 2
      "Last updated #{time_ago_in_words(time_to_check)} ago"
    else
      "Updated #{time_to_check.strftime("%m-%d-%Y")}"
    end
  end


  def distance_of_time_in(unit, from, to)
    diff = to - from

    if 1.respond_to? unit
      distance = diff / 1.send(unit)
      distance.abs.round
    else
      raise ArgumentError, "#{unit.inspect} is not supported as unit"
    end
  end
end


module ApplicationHelper

  include Pagy::Frontend
  
  # Map flash error types to specific classes
  FLASH_COLOR = {
    notice: 'slate',
    alert: 'red',
    error: 'orange',
    success: 'green'
  }.freeze

  def flash_messages(flash)
    return if flash.blank?

    flash.map do |type, msg| 
      content_tag :div, class: "w-full mb-5", 'x-data': "{ openFlash: 1, msg: '#{msg}'}" do
        content_tag :div, "x-if: msg" do
          content_tag :div, class: "flex items-center justify-between px-4 py-4 rounded text-white bg-#{FLASH_COLOR[type.to_sym]}-500 border-2 border-#{FLASH_COLOR[type.to_sym]}-500" do          
            concat msg
            # concat :span, 'X', "x-on:click=\"msg = ''\""
            concat close_button
          end
        end
      end 
    end.join
  end

  def close_button
    content_tag :span, "x-on:click=\"msg = ''\"" do
      "X"
    end
  end

  def logo
    concat image_tag('logo.png', class: 'h-9 w-9 float-left mr-2')
    concat content_tag(:h3, "Trustb.in", class: 'font-semibold text-gray-800 text-lg')
    concat content_tag(:div, "Private code bin for engineering teams", class: 'text-sm')
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


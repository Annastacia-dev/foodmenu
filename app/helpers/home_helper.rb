module HomeHelper
  def greeting
    if Time.now.hour < 12
      "Good Morning"
    elsif Time.now.hour < 18
      "Good Afternoon"
    else
      "Good Evening"
    end
  end
end

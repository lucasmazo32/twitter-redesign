require 'whirly'

Whirly.configure spinner: "dots"

Whirly.start do
  10.times do |x|
    Whirly.status = x
    sleep 0.2
  end
end

Whirly.start do
  10.times do |x|
    Whirly.status = x
    sleep 0.2
  end
end
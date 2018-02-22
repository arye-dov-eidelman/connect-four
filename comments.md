commands{
  rspec spec/01_connect_four.rb
  ruby bin/connectfour
}

colored circles{
  colored text: https://stackoverflow.com/questions/1489183/colorized-ruby-output

  red style_id = 34
  blue style_id = 31
  grey style_id = 37
  reset style_id = 0

  set style \e[31m
  text
  reset style \e[0m

  solid circle = "\u25CF"

  all together
  \e[#{style_id}m#{TEXT}\e[0m
}

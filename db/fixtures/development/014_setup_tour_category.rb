Tour::Category.seed do |s|
  s.id = 1
  s.code = 'inday'
  s.name = '日帰りツアー'
end

Tour::Category.seed do |s|
  s.id = 2
  s.code = 'stay'
  s.name = '宿泊ツアー'
end

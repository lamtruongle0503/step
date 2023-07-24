Payment.seed do |s|
  s.id = 1
  s.name = 'クレジットカード'
  s.code = 'credit_card'
end

Payment.seed do |s|
  s.id = 2
  s.name = 'コンビニ'
  s.code = 'convenience_store'
end

Payment.seed do |s|
  s.id = 3
  s.name = '代引'
  s.code = 'on_delivery'
end

Payment.seed do |s|
  s.id = 4
  s.name = '銀行振込'
  s.code = 'bank_transfer'
end

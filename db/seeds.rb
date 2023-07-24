# frozen_string_literal: true

require "factory_bot_rails"

puts "start create database seed"

ApplicationRecord.transaction do
  puts "Start seed"

  puts "Create user"
  users = 10.times.map do
    FactoryBot.create :user
  end

  puts "Create category"
  categories = 10.times.map do
    FactoryBot.create :category
  end

  puts "Create product"
  payments = Payment.all
  area_settings = AreaSetting.all
  size = %w[X M L]
  products = 10.times.map do
    FactoryBot.create :product, category: categories.sample do |product|
      3.times do |n|
        FactoryBot.create :product_size, product: product, name: size[n]
        FactoryBot.create :delivery_setting, product: product
        FactoryBot.create :delivery_time_setting, product: product
        FactoryBot.create :payments_product, product: product, payment: payments[n]
        FactoryBot.create :product_area_setting, product: product, area_setting: area_settings[n]
      end
    end
  end

  puts "Create order"
  product_sizes = ProductSize.all
  users = User.all
  20.times do
    FactoryBot.create :order, user: users.sample do |order|
      FactoryBot.create :order_product, order: order, product_size: product_sizes.sample
      FactoryBot.create :order_info, order: order
    end
  end
end

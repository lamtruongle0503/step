# frozen_string_literal: true

class Admin::Hotels::AggregateOrders::AttributesSerializer < ApplicationSerializer
  attributes :credit_card_and_web, :credit_card_and_consignment, :credit_card_and_request,
             :on_spot_and_web, :on_spot_and_request, :on_spot_and_consignment,
             :cancel_credit_card_and_web, :cancel_credit_card_and_consignment,
             :cancel_credit_card_and_request, :cancel_on_spot_and_web,
             :cancel_on_spot_and_request, :cancel_on_spot_and_consignment

  def credit_card_and_web
    object[:credit_card_and_web].map do |obj|
      Admin::Hotels::AggregateOrders::PaymentSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def credit_card_and_consignment
    object[:credit_card_and_consignment].map do |obj|
      Admin::Hotels::AggregateOrders::PaymentSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def credit_card_and_request
    object[:credit_card_and_request].map do |obj|
      Admin::Hotels::AggregateOrders::PaymentSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def on_spot_and_web
    object[:on_spot_and_web].map do |obj|
      Admin::Hotels::AggregateOrders::PaymentSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def on_spot_and_request
    object[:on_spot_and_request].map do |obj|
      Admin::Hotels::AggregateOrders::PaymentSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def on_spot_and_consignment
    object[:on_spot_and_consignment].map do |obj|
      Admin::Hotels::AggregateOrders::PaymentSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def cancel_credit_card_and_web
    object[:cancel_credit_card_and_web].map do |obj|
      Admin::Hotels::AggregateOrders::CancellationSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def cancel_credit_card_and_consignment
    object[:cancel_credit_card_and_consignment].map do |obj|
      Admin::Hotels::AggregateOrders::CancellationSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def cancel_credit_card_and_request
    object[:cancel_credit_card_and_request].map do |obj|
      Admin::Hotels::AggregateOrders::CancellationSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def cancel_on_spot_and_web
    object[:cancel_on_spot_and_web].map do |obj|
      Admin::Hotels::AggregateOrders::CancellationSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def cancel_on_spot_and_request
    object[:cancel_on_spot_and_request].map do |obj|
      Admin::Hotels::AggregateOrders::CancellationSerializer::AttributesSerializer.new(obj).as_json
    end
  end

  def cancel_on_spot_and_consignment
    object[:cancel_on_spot_and_consignment].map do |obj|
      Admin::Hotels::AggregateOrders::CancellationSerializer::AttributesSerializer.new(obj).as_json
    end
  end
end

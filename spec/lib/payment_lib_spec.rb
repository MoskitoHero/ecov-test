# frozen_string_literal: true

require 'spec_helper'
require 'payment_lib'

describe PaymentLib do
  before :each do
    @payment = PaymentLib.new('DGFHJK')
  end

  it 'needs an API key to initialize' do
    expect { PaymentLib.new }.to raise_error(ArgumentError)
  end

  it 'creates a bill' do
    result = @payment.bill(10.0)
    expect(result[:status]).to be('billed')
  end

  it 'reimburses a bill' do
    id = @payment.bill(10.0)[:id]
    result = @payment.reimburse(id)
    expect(result[:status]).to be('reimbursed')
  end

  it 'pays a bill' do
    id = @payment.bill(10.0)[:id]
    result = @payment.pay(id)
    expect(result[:status]).to be('paid')
  end

  it 'needs a proper id' do
    bill = @payment.bill(10.0)
    reimburse_result = @payment.reimburse('UNEXISTINGID')
    pay_result = @payment.pay('UNEXISTINGID')
    expect(reimburse_result).to be(bill)
    expect(pay_result).to be(bill)
  end
end

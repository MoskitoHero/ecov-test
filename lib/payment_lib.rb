# frozen_string_literal: true

class PaymentLib
  attr_accessor :api_key

  def initialize(api_key)
    @api_key = api_key
    @payment = {
      status: 'empty',
      amount: 0.0,
      id: 'XXXXXXX-id'
    }
  end

  def bill(amount)
    payment.merge!(status: 'billed', amount: amount)
  end

  def reimburse(id)
    if id == payment[:id]
      payment.merge!(status: 'reimbursed')
    else
      payment
    end
  end

  def pay(id)
    if id == payment[:id]
      payment.merge!(status: 'paid')
    else
      payment
    end
  end

  private

  def payment
    @payment
  end

  def payment=(payment)
    @payment = payment
  end
end

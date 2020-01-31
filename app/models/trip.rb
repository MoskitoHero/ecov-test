# frozen_string_literal: true

class Trip < ApplicationRecord
  self.primary_key = 'uid'

  after_initialize :set_defaults, if: :new_record?
  before_validation :update_payment
  after_save :log_status, if: :saved_change_to_status?
  validates_length_of :uid, is: 4, message: "L'identifiant de Trajet doit faire 4 caractères"
  validates_uniqueness_of :uid
  validates :status, inclusion: { in: %w(CREATED STARTED CANCELLED),
    message: "%{value} n'est pas un statut correct" }
  validates :departure, :destination, presence: true

  private

  def init_status
    self.status = 'CREATED'
  end

  def init_uid
    self.uid = loop do
      hash = SecureRandom.hex(2)
      break hash unless Trip.exists?(uid: hash)
    end
  end

  def log_status
    Rails.logger.info "STATUS CHANGE: Trip #{uid} is now #{status}"
  end

  # NOTE: Je ne pense pas qu'il faille mettre à jour le paiement depuis le modèle Trip.
  # J'ai suivi la checklist qui intégrait ça dans la partie "modèle", mais ceci n'est
  # pas en accord avec le Single Responsibility Principle. Trip en sait beaucoup trop.
  # D'ailleurs les specs commencent à partir en vrac à ce moment-là.
  # J'ai voulu faire un Job, mais pour le paiement, je trouve ça trop découplé.
  # Je serais d'avis de faire la coordination Trajet/Paiement dans le controleur.
  def update_payment
    case status
    when 'CREATED'
      self.payment_data = PaymentLib.new('MYSECRETKEY').bill(3.0)
    when 'STARTED'
      self.payment_data = PaymentLib.new('MYSECRETKEY').pay(payment_data['id'])
    when 'CANCELLED'
      self.payment_data = PaymentLib.new('MYSECRETKEY').reimburse(payment_data['id'])
    end
  end

  def set_defaults
    init_status
    init_uid
  end
end

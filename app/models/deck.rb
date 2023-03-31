class Deck < ApplicationRecord
  validates_presence_of :category
  has_many :deck_cards
  has_many :sound_cards, through: :deck_cards
  after_create :get_cards

  private

  def get_cards
    scs = initial_sound_cards
    scs.each do |sc|
      DeckCard.create(sound_card_id: sc.id, deck_id: self.id)
    end
  end

  def initial_sound_cards
    unless category.downcase.include?('misc')
      SoundCard.where("lower(category) = ?", category.downcase).shuffle.shuffle.first(8)
    else
      SoundCard.all.shuffle.shuffle.first(8)
    end
  end
end
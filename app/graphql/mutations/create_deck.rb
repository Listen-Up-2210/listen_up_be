# frozen_string_literal: true

module Mutations
  class CreateDeck < Mutations::BaseMutation
    argument :category, String, required: true
    argument :difficulty, String, required: true

    field :deck, Types::DeckType
    field :errors, [String], null: false

    def resolve(category:, difficulty:)
      deck = Deck.new(category: category, difficulty: difficulty)
      if deck.save
        if deck.sound_cards.count.positive?
          {
            deck: deck,
            errors: []
          }
        else
          deck.destroy
          {
            deck: nil,
            errors: ["There are no sound cards for category #{category} with difficulty #{difficulty}"]
          }
        end
      else
        {
          deck: nil,
          errors: deck.errors.full_messages
        }
      end
    end
  end
end

module Searchable
  extend ActiveSupport::Concern

  included do
    include PgSearch::Model

    scope :search_order, -> { order('search_rank DESC') }
  end

  class_methods do
    def searchable(**options)
      pg_search_scope :search,
                      against: options[:against],
                      associated_against: options[:associated_against],
                      using: {
                        tsearch: {
                          any_word: true,
                          prefix: true,
                          dictionary: 'english',
                        }
                      }
    end
  end
end
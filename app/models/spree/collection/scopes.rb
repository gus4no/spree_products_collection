module Spree
  class Collection < ActiveRecord::Base
    cattr_accessor :search_scopes do
      []
    end

    def self.add_search_scope(name, &block)
      self.singleton_class.send(:define_method, name.to_sym, &block)
      search_scopes << name.to_sym
    end

    add_search_scope :in_taxons do |*taxons|
      taxons = get_taxons(taxons)
      taxons.first ? prepare_taxon_conditions(taxons) : scoped
    end

    private

      # specifically avoid having an order for taxon search (conflicts with main order)
      def self.prepare_taxon_conditions(taxons)
        ids = taxons.map { |taxon| taxon.self_and_descendants.pluck(:id) }.flatten.uniq
        joins(:taxons).where("#{Taxon.table_name}.id" => ids)
      end

      def self.get_taxons(*ids_or_records_or_names)
        taxons = Taxon.table_name
        ids_or_records_or_names.flatten.map { |t|
          case t
            when Integer then Taxon.find_by(id: t)
            when ActiveRecord::Base then t
            when String
              Taxon.find_by(name: t) ||
                  Taxon.where("#{taxons}.permalink LIKE ? OR #{taxons}.permalink = ?", "%/#{t}/", "#{t}/").first
          end
        }.compact.flatten.uniq
      end
  end
end

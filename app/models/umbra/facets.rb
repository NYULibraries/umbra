module Umbra
  module Facets
    def self.included(base)
      base.send :extend, ClassMethods
    end
    module ClassMethods
      attr_accessor :facets
      def add_facets(*facets_to_add)
        facets_to_add.each {|facet| facets << facet }
      end
      def facets_taggable
        facets.collect {|facet| facet.to_s.pluralize.to_sym }
      end
      def facets_accessible
        facets.collect {|facet| facet.to_s.concat("_list").to_sym }
      end
      def facets 
        @facets ||= []
      end
    end
  end
end
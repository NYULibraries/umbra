class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior
  include Umbra::Repositories
  self.default_processor_chain += [:add_collection_to_solr]

  # Adding a collection to solr params
  def add_collection_to_solr(solr_parameters)
    solr_parameters[:fq] << "collection_ss:#{get_repository_admin_code(blacklight_params[:collection])}" unless get_repository_admin_code(blacklight_params[:collection]).nil?
  end
end

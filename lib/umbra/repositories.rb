module Umbra
  module Repositories
    extend ActiveSupport::Concern

    # Return which Hash set to use
    #
    # * Return the Catalog repositories
    def repositories
      @repositories ||= repositories_from_yaml["Catalog"]["repositories"]
    end

    def get_repository_admin_code(collection_code)
      repositories.try(:[],collection_code).try(:[],:admin_code)
    end

    def get_repository_display(collection_code)
      repositories.try(:[],collection_code).try(:[],:display)
    end

  private

    # Load YAML file with repos info into Hash
    def repositories_from_yaml
      @repositories_from_yaml ||= YAML.load_file( File.join(Rails.root, "config", "repositories.yml") ).with_indifferent_access
    end

  end
end

## for using a different value for the id field of your Solr documents
#Sunspot::Indexer.module_eval do
# alias :old_prepare :prepare
# def prepare(model)
#   document = old_prepare(model)
#   # When deleting the model.id is present but no the to_param function
#   # hence this little decision to make
#   model_id = (!model.id.nil?) ? model.id : model.to_param.to_i
#   document.fields_by_name(:id).first.value = "Umbra::Record #{model_id}"
#   document.fields_by_name(:type).first.value = "Umbra::Record"
#   document
# end
#
# alias :old_remove :remove  
# def remove(*models)
#   @connection.delete_by_id(
#     models.map do |model| 
#       prepare(model).fields_by_name(:id).first.value
#     end
#   )
# end
#
#end
#
## to allow searching with Sunspot's DSL as well to retrieve your models
#class Sunspot::Search::Hit
# def initialize(raw_hit, highlights, search) 
#   @class_name, @primary_key = *raw_hit['id'].match(/([^ ]+) (.+)/)[1..2]
#   @class_name = "Umbra::Record"
#   @score = raw_hit['score']
#   @search = search
#   @stored_values = raw_hit
#   @stored_cache = {}
#   @highlights = highlights
# end
#end
# MonkeyPatch blacklight to allow non-strong parameters for Rails4
# This is transitional need while we don't use strong parameters
Blacklight::Search.class_eval { attr_accessible :query_params }
Blacklight::Bookmark.class_eval { attr_accessible :id, :document_id, :document_type, :title }

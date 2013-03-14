module RecordHelper
  
  #
  # Return sorted list of facets
  #
  
  def subject_controlled_list
    @subject_controlled_list ||= Umbra::Record.subject_controlled_counts.sort_by(&:name)
  end
  
  def extent_list
    @extent_list ||= Umbra::Record.extent_counts.sort_by(&:name)
  end
  
  def coverage_spatial_list
    @coverage_spatial_list ||= Umbra::Record.coverage_spatial_counts.sort_by(&:name)
  end
  
  def coverage_temporal_list
    @coverage_temporal_list ||= Umbra::Record.coverage_temporal_counts.sort_by(&:name)
  end
  
  def coverage_jurisdiction_list
    @coverage_jurisdiction_list ||= Umbra::Record.coverage_jurisdiction_counts.sort_by(&:name)
  end
  
  def source_list
    @source_list ||= Umbra::Record.source_counts.sort_by(&:name)
  end
  
  def language_list
    @language_list ||= Umbra::Record.language_counts.sort_by(&:name)
  end
  
  def accrualPeriodicity_list
    @accrualPeriodicity_list ||= Umbra::Record.accrualPeriodicity_counts.sort_by(&:name)
  end
  
  def subject_tag_list
    @subject_tag_list ||= Umbra::Record.subject_tag_counts.sort_by(&:name)
  end

end
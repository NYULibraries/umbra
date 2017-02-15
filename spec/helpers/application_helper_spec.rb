require 'spec_helper'

describe ApplicationHelper do

  include ApplicationHelper

  let(:title_ssm) { "<b>The Title</b>" }
  let(:identifier_ss) { "http://google.com" }
  let(:field) { :title_ssm }
  let(:solr_response) do
    Blacklight::Solr::Response.new({}, :solr_parameters => {:qf => "fieldOne^2.3 fieldTwo fieldThree^0.4", :pf => "", :spellcheck => 'false', :rows => "55", :sort => "request_params_sort" })
  end
  let(:document) do
    {
      :document => SolrDocument.new({
        :title_ssm => [title_ssm],
        :identifier_ss => identifier_ss
      }, solr_response),
      :field => field
    }.with_indifferent_access
  end

  describe ".link_field" do
    subject { link_field(document) }
    let(:field) { :identifier_ss }
    it { should eql '<a target="_blank" href="http://google.com">Link to resource</a>' }
  end

  describe ".html_field" do
    subject { html_field(document) }
    it { should eql "<b>The Title</b>" }
  end

  describe ".sortable" do
    let(:column) { "username" }
    let(:title) { nil }
    let(:sort_direction) { "asc" }
    let(:sort_column) { "username" }
    let(:params) { {controller: 'users', action: 'index'}}
    subject { sortable(column, title) }

    context "when column is same as current column" do
      it { should match "Username" }

      context "when direction is asc" do
        it { should match "asc" }
      end

      context "when direction is desc" do
        let(:sort_direction) { "desc" }
        it { should match "desc" }
      end
    end

    context "when column is different than current column" do
      let(:column) { "first_name" }
      it { should match "First Name" }

      context "when direction is asc" do
        let(:sort_direction) { "asc" }
        it { should match "asc" }
      end

      context "when direction is desc" do
        let(:sort_direction) { "desc" }
        it { should match "asc" }
      end
    end
  end

  def icon_tag(name)
    image_tag "icon.gif"
  end

end

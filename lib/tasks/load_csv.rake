require Rails.root.join('lib','umbra','collections.rb')
require Rails.root.join('lib','umbra','csv_upload.rb')
namespace :umbra do
  desc "Import from csv file"
  task :load_csv, [:csv_file, :encoding] => :environment do |t, args|
    args.with_defaults(csv_file: "db/csv/dss.csv", encoding: "windows-1251:utf-8")
    # We don't care about permissions when the load is called from the command line,
    # so we can just create a dummy admin user
    dummy_user = User.new(email: "user@nyu.edu", firstname: "Julius", username: "jcVI", user_attributes: { umbra_admin: true, umbra_admin_collections: "global" })
    Umbra::CsvUpload.new(csv_file(args[:csv_file]), dummy_user, args[:encoding]).upload
  end
end

def csv_file(filename, content_type = "text/csv")
  file = Rails.root.join(filename)
  csv_fixture = ActionDispatch::Http::UploadedFile.new(tempfile: file, filename: File.basename(file))
  csv_fixture.content_type = content_type
  return csv_fixture
end

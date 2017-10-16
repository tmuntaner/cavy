require 'fileutils'

task :cavy_before_assets_precompile do
  puts '[+] Cavy - Copying non-digested assets to /public'
  source_root = File.expand_path('../../../app/assets/nodigest/cavy/*', __FILE__)
  destination_path = File.expand_path(File.join(Rails.public_path, 'assets', 'cavy'), __FILE__)

  Dir[source_root].try(:each) do |file|
    puts "[+] Copying #{file} to public"
    FileUtils.cp_r(file, destination_path)
  end
end

Rake::Task['assets:precompile'].enhance ['cavy_before_assets_precompile']

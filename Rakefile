gemspec = eval(File.read("tiedye.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["tiedye.gemspec"] do
  system "gem build tiedye.gemspec"
end

desc "Run the tests"
task :test do
  $:.unshift "lib"
  $:.unshift "test"
  $:.unshift "."
  Dir["test/**/test_*.rb"].each { |f| require f }
end
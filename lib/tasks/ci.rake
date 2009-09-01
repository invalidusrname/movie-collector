namespace :ci do
  task :copy_yml do
    system("cp #{Rails.root}/../../shared/movie_collector/* #{Rails.root}/config/")
  end

  desc "Prepare for CI and run entire test suite"
  task :build => ['ci:copy_yml', 'db:migrate', 'spec', 'features'] do
  end
end

# Rails 7 with importmap doesn't use asset pipeline
# These tasks are no-ops to prevent Render from failing
namespace :assets do
  desc "No-op task for assets:precompile (Rails 7 uses importmap)"
  task :precompile do
    puts "Skipping asset precompilation - Rails 7 uses importmap instead of asset pipeline"
  end

  desc "No-op task for assets:clean (Rails 7 uses importmap)"
  task :clean do
    puts "Skipping asset cleanup - Rails 7 uses importmap instead of asset pipeline"
  end
end


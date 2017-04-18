
task :ci => [:dump, :test]

task :dump do
  sh 'vim --version'
end

task :test do
  begin
    FileUtils.mkdir('config') unless File.directory?('config')
    sh 'bundle exec vim-flavor test'
  ensure
    FileUtils.rm_r('config')
  end
end

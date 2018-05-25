require 'fileutils'
puts "please enter a folder name"
foldername = gets.chomp

Dir.mkdir(File.join(Dir.home, foldername))
Dir.mkdir(File.join(Dir.home, foldername, "lib"))
Dir.mkdir(File.join(Dir.home, foldername, "spec"))
gemfile_path = File.join(Dir.home, foldername, 'Gemfile')
FileUtils.touch(gemfile_path)
gemfile_contents = <<~HEREDOC
  source 'https://rubygems.org'

  gem 'rspec'
  gem 'pry'

HEREDOC
File.open gemfile_path, 'a' do |f|
  f.write gemfile_contents
end
classes = ''
while classes != 'none more'
  puts 'Please enter class name'
  puts "To leave type \"none more\""
  class_name = gets.chomp

  if class_name != 'none more'
    class_path = File.join(Dir.home, foldername, 'lib', "#{class_name.downcase}.rb")
    spec_path = File.join(Dir.home, foldername, 'spec', "#{class_name.downcase}_spec.rb")

    File.open class_path, 'a' do |f|
      f.write "class #{class_name.capitalize}\n\nend\n\n"
    end
    File.open spec_path, 'a' do |f|
      f.write "require \"rspec\"\nrequire \"#{class_name.downcase}\"\n\ndescribe('#{class_name.capitalize}') do\n  it('') do\n    expect(#{class_name.capitalize}.).to eq()\n  end\nend\n"
    end
  else
    break
  end
end

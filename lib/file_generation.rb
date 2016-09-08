
require 'erb'

module FileGeneration

  def self.export_html(file_name, queue)
  template_letter = File.read "form_letter.erb"
  erb_template = ERB.new template_letter
  binding.pry
  form_letter = erb_template.result(binding)
  format_html(file_name, form_letter)
  end

  def  self.format_html(file_name, form_letter)
  File.open(file_name,'w') do |file|
    file.puts form_letter
  end
end
end

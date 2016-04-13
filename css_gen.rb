require 'yaml'
require 'json'
require 'ostruct'


def css_value s
	return s.to_s + " !important;"
end

def add s
	@result_css += s
end

c = OpenStruct.new(YAML.load_file('config.yml'))



@result_css = <<~'EOF'
	@-moz-document regexp("https?://new\.vk\.com(?!(/stats)).*") {
EOF

#body background
if c.background
	add <<~EOF
		body {
			background: #{css_value c.background}
		}
	EOF
end

#remove rounded avatars
if c.delete_border_radius
	add <<~EOF
	#{c.delete_border_radius.join","} {
		border-radius: #{css_value "0px"}
	}
	EOF
end


for_concat = File.read("for_concat.css")
@result_css += for_concat + "}"
File.write("result.css", @result_css)
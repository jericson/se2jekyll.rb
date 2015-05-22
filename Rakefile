task default: %w[test]

task :test do
  # Canonical example
  sh "./se2jekyll.rb stackoverflow 1732454 > xml_regex_answer.md"
  sh "cksum xml_regex_answer.md && rm xml_regex_answer.md"
end

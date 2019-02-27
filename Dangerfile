def validate_template(pr_body)

	failure("You did not complete the `Type of change(s)` checklist") if !meets_types_lines(pr_body)
	failure("You did not complete the `Before you begin` checklist") if !meets_required_lines(pr_body)

end

def meets_required_lines(pr_body)
	lines = Array.new

	pr_body.each_line do  |line| 
		if line.include?("<!-- require_") && line.start_with?("- [x]")			

			lines.push(line)
		end
	end

	return !lines.empty?	

end

def meets_types_lines(pr_body) 
	lines = Array.new

	pr_body.each_line do  |line| 
		if line.include?("<!-- type_") && line.start_with?("- [x]")
			lines.push(line)
		end
	end
	return !lines.empty?
end

validate_template(github.pr_body)

# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]" || github.pr_labels.any? { |label| label.downcase.include? "wip" }

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

#suggest squashing if there are a lot of commits
warn("Consider squashing this PR") if git.commits.count > 10
failure("You must squash this PR") if  git.commits.count > 50


#Basic rules around PR requirements
failure("You need a meaningful description of this PR") if github.pr_body.length < 5

failure("Please add the JIRA ticket to the title") if !github.pr_title.include?("CNBCMAPP")

errors = danger.status_report[:errors].count
if errors > 0 
	message = "### Danger Completed with #{errors} errors\n"	
	message << "![Uh Uh Uh!](https://media.giphy.com/media/5ftsmLIqktHQA/giphy.gif)"
	markdown message
else
	the_coding_love.random
end


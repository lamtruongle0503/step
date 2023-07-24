# frozen_string_literal: true

### Skipping Settings ###
suffixes = [
  'Release ',             # git-pr-release
  'Develop from Staging', # for Release
  'Staging from Master',  # for Release
]

programmatic = github.pr_author == 'dependabot[bot]' ||
               github.pr_title.start_with?(*suffixes)

message(<<~MSG) && return if programmatic
  We don't need to check this Pull Request - skipping `danger` run
MSG

case ENV['CIRCLE_JOB']
when 'test'
  ### GitHub Comment Settings ###
  # Ignore inline messages which lay outside a diff's range
  github.dismiss_out_of_range_messages

  ### for Rubocop ###
  rubocop.lint(force_exclusion: true,
               inline_comment:  true)

  ### for rails_best_practices ###
  rails_best_practices.lint

  ### for Reek ###
  reek.lint

  # Ensure there is a summary for a pr
  failure(<<~MSG) if github.pr_body.include?('___WRITE_HERE___')
    Please provide a summary in the Pull Request description
  MSG

  # Ensure that all prs have an assignee
  failure(<<~MSG) unless github.pr_json['assignee']
    This PR does not have any assignees yet.
  MSG

  # Warn really big diffs
  warn(<<~MSG) if git.lines_of_code > 300
    We cannot handle the scale of this PR
  MSG

  # Warn when a pr is classed as work in progress
  warn(<<~MSG) if github.pr_title.include?('[WIP]')
    PR is classed as Work in Progress
  MSG

  # Note when a pr cannot be manually merged, which goes away when you can
  warn(<<~MSG, sticky: false) unless github.pr_json['mergeable']
    This PR cannot be merged yet.
  MSG
end

# vim: set ft=ruby:

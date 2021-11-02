#!/bin/sh -l

bundle install
bundle exec ruby main.rb $INPUT_TOKEN $INPUT_REPO $INPUT_RELEASE_BRANCH_REGEXP $INPUT_PR_TITLE $INPUT_PR_BODY

#!/usr/bin/env ruby

require 'thor'
require_relative 'grader'

class SevalCLI < Thor

  desc "grade FIELD SCRIPT", "Grade a student"
  def grade(field, script)
    Grader.new(open(field).read.split("\n"),
               open(script).read.split("\n")).run
  end

end

SevalCLI.start(ARGV)
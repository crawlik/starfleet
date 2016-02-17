# Starfleet Fun

# Prerequisites

Ruby 2.2 & bundler gem. Please refer to
https://www.ruby-lang.org/en/documentation/installation/ for installation
instructions.

# Bootstrapping

```bash
bundle install
```

# Running tests

```bash
rspec spec
```

# Usage

```shell
$ ruby seval.rb
Commands:
  seval.rb grade FIELD SCRIPT  # Grade a student
    seval.rb help [COMMAND]    # Describe available commands or one specific command
```
You can use included fixtures that cover major use cases

```bash
ruby seval.rb grade spec/fixtures/input/field.1 spec/fixtures/input/script.1
Step 1

x

gamma

.

pass (5)
```

# Technicality behind the project

TDD parctice was used during sketching up of this project. Files in
spec/fixtures represent real input and correct expected output for the grade
command. Tests were developed first and left in a broken state. Implementation followed
which brought all tests to a happy state, but that doesn't mean that this small fun
project is bug free. It just meets initiallily imposed requirements.

The following entities were identified as useful for implementation and modeled.

Ship class models starfleet ship behavior and requires a cuboid.
Field class models space cubiod.
Script class plays a role of script container.
Grader class plays a role of a driver to control data (script, field) and
operate a ship.
seval is a simple cli wrapper and stands for Student EVALuator.

Proposed models give us separation of concerns and allow adding unit tests for
those concerns in order to imporove code statbility and test coverage.

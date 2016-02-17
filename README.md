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

It is coming soon

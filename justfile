# Run `just --list` to see all available commands

# Default recipe shows help
default:
    @just --list

# === Development Server Commands ===

# Start dev server
serve:
    bundle exec jekyll serve --verbose --livereload

# Build site
build:
    bundle exec jekyll b --verbose --watch

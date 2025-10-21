# Makefile for the rust-cli-chat project

# Default target
all: build

# Install dependencies
install-dependencies:
	# For Ubuntu/Debian
	sudo apt-get install libncursesw5-dev
	# For Fedora
	# sudo dnf install ncurses-devel

# Build the project
build:
	cargo build --release

# Run the server
run-server:
	cargo run --bin server

# Run the client
# Usage: make run-client username=<username>
run-client:
	cargo run --bin client $(username)

# Clean the project
clean:
	cargo clean

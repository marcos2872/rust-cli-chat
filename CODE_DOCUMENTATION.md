# Code Documentation

This document provides a detailed explanation of the Rust CLI Chat application's codebase.

## Project Structure

```
.
├── .gitignore
├── Cargo.lock
├── Cargo.toml
├── Makefile
├── README.md
├── images
│   ├── client1.png
│   ├── client2.png
│   └── server.png
└── src
    └── bin
        ├── client.rs
        └── server.rs
```

-   **`src/bin/client.rs`**: The client application.
-   **`src/bin/server.rs`**: The server application.
-   **`images`**: Contains screenshots of the application.
-   **`Cargo.toml`**: The package manager configuration file for Rust.
-   **`Makefile`**: Contains helper commands for building and running the project.

## Data Structures

Two main data structures are used for communication between the client and server:

### `ChatMessage`

```rust
struct ChatMessage {
    pub username: String,
    pub content: String,
    pub timestamp: String,
    message_type: MessageType,
}
```

This struct represents a single chat message. It contains the sender's username, the message content, a timestamp, and the message type.

### `MessageType`

```rust
enum MessageType {
    UserMessage,
    SystemNotification,
}
```

This enum defines the type of message. It can be a regular user message or a system notification (e.g., when a user joins or leaves the chat).

## Server (`server.rs`)

The server is responsible for handling client connections and broadcasting messages.

### `main` function

-   Initializes a TCP listener on `127.0.0.1:8082`.
-   Creates a broadcast channel for communication between threads.
-   Enters a loop to accept new client connections.
-   For each new connection, it spawns a new asynchronous task to handle the connection.

### `handle_connection` function

-   Takes a `TcpStream`, a broadcast sender, and a broadcast receiver as input.
-   Reads the username from the client.
-   Sends a system notification to all clients that a new user has joined.
-   Enters a loop to handle incoming messages from the client and outgoing messages from the broadcast channel.
-   When a client disconnects, it sends a system notification to all clients that the user has left.

## Client (`client.rs`)

The client provides a terminal-based user interface for the chat.

### `main` function

-   Parses the username from the command-line arguments.
-   Initializes the `cursive` terminal UI library.
-   Creates the UI layout, including a message view, an input view, and a header.
-   Connects to the server at `127.0.0.1:8082`.
-   Spawns a new asynchronous task to listen for incoming messages from the server.
-   Runs the `cursive` event loop.

### `send_message` function

-   This function is called when the user submits a message in the input view.
-   It handles special commands like `/help`, `/clear`, and `/quit`.
-   For regular messages, it sends the message to the server.

### `create_retro_theme` function

-   This function creates a custom retro-style theme for the `cursive` UI.

## Dependencies

-   **`tokio`**: An asynchronous runtime for Rust. Used for handling network connections and asynchronous tasks.
-   **`cursive`**: A library for building terminal-based user interfaces.
-   **`serde`**: A framework for serializing and deserializing Rust data structures. Used for converting `ChatMessage` to and from JSON.
-   **`serde_json`**: A JSON implementation for `serde`.
-   **`chrono`**: A library for handling dates and times.

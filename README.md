# Books



# Prerequisites
  - (asdf)[https://asdf-vm.com]
  - 
# Setup
  - Clone repo: `git clone https://github.com/nickagliano/books.git`
  - Move into directory: `cd books`
  - Install erlang, elixir, and nodejs versions: `asdf install`
  - Install dependencies: `mix deps.get`
  - Create and migrate database: `mix ecto.setup`
  - 
  - Install Node.js dependencies 
    - Move into the `assets` directory: `cd assets`
    - Install dependencies: `npm install`
  - Start Phoenix endpoint with `mix phx.server`
  - Open browser to [`localhost:4000`](http://localhost:4000)

# Development
- `mix credo` to run static analysis
# Deploying to production
  - This app isn't deployed anywhere yet. I'll cross that bridge when we get there.
  - Might decide to use Gigalixir
## Phoenix resources
  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

# Contributing

1) Fork it!
2) Create your feature branch (git checkout -b my-new-feature)
3) Commit your changes (git commit -am 'Add some feature')
4) Push to the branch (git push origin my-new-feature)
5) Create new Pull Request


# Author
Nick Agliano (@nickagliano)

# License
Books is released under the MIT License. See the LICENSE file for further details.

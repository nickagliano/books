# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Books.Repo.insert!(%Books.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Books.Repo
alias Books.Chats

Chats.create_chat (
  %{ room_name: "Chat Room 1" }
)

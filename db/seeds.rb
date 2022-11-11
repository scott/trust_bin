
user = User.create!(email: 'admin@test.com', password: '12345678', uuid: SecureRandom.uuid, role: 'admin')
snippet_uuid = SecureRandom.uuid
snippet = Snippet.create!(name: 'Hello World in Ruby', description: 'demo of Ruby highlighting', content: "# Hello World in Ruby
puts \"Hello World!\"", uuid: snippet_uuid, parent_uuid: snippet_uuid, user_id: user.id, visibility: 'org', language: 'ruby')
snippet = Snippet.create!(name: 'Hello World in Ruby 2', description: 'demo of Ruby highlighting', content: "# VERSION 2
# Hello World in Ruby
puts \"Hello World!\"", uuid: SecureRandom.uuid, parent_uuid: snippet_uuid, user_id: user.id, visibility: 'org', language: 'ruby', version: 2)
snippet_uuid = SecureRandom.uuid
snippet = Snippet.create!(name: 'Hello World in Go', description: 'A sample of Go code', content: "// Hello world in Go
package main

import \"fmt\"

func main() {
 fmt.Printf(\"Hello World\n\")
}
", uuid: snippet_uuid, parent_uuid: snippet_uuid, user_id: user.id, visibility: 'org', language: 'go')

namespace :db do
  desc 'Initialize and seed the db if it has not been yet'
  task :initialize => :environment do
    if User.all.size == 0
      user = User.create!(email: ENV['INITIAL_ADMIN_USER'], password: ENV['INITIAL_ADMIN_PASSWORD'], uuid: SecureRandom.uuid, role: 'admin')

      # Set up initial start code snippets to demonstrate system
      snippet_uuid = SecureRandom.uuid
      snippet = Snippet.create!(name: 'Ruby sample', description: 'demo of Ruby highlighting', content: "#
      # Function to evaluate a polynomial at x.  The polynomial is given
      # as a list of coefficients, from the greatest to the least.
      def polyval(x, coef)
          sum = 0
          coef = coef.clone           # Don't want to destroy the original
          while true
              sum += coef.shift       # Add and remove the next coef
              break if coef.empty?    # If no more, done entirely.
              sum *= x                # This happens the right number of times.
          end
          return sum
      end", uuid: snippet_uuid, parent_uuid: snippet_uuid, user_id: user.id, visibility: 'org', language: 'ruby')
      snippet = Snippet.create!(name: 'Ruby sample', description: 'demo of Ruby highlighting', content: "# VERSION 2
      # Function to evaluate a polynomial at x.  The polynomial is given
      # as a list of coefficients, from the greatest to the least.
      def polyval(x, coef)
          sum = 0
          coef = coef.clone           # Don't want to destroy the original
          while true
              sum += coef.shift       # Add and remove the next coef
              break if coef.empty?    # If no more, done entirely.
              sum *= x                # This happens the right number of times.
          end
          return sum
      end", uuid: SecureRandom.uuid, parent_uuid: snippet_uuid, user_id: user.id, visibility: 'org', language: 'ruby', version: 2)
      snippet_uuid = SecureRandom.uuid
      snippet = Snippet.create!(name: 'Golang code', description: 'A sample of Go code', content: "// Prime Sieve in Go.
      // Taken from the Go specification.
      // Copyright © The Go Authors.

      package main

      import \"fmt\"

      // Send the sequence 2, 3, 4, ... to channel 'ch'.
      func generate(ch chan<- int) {
        for i := 2; ; i++ {
          ch <- i  // Send 'i' to channel 'ch'
        }
      }

      // Copy the values from channel 'src' to channel 'dst',
      // removing those divisible by 'prime'.
      func filter(src <-chan int, dst chan<- int, prime int) {
        for i := range src {    // Loop over values received from 'src'.
          if i%prime != 0 {
            dst <- i  // Send 'i' to channel 'dst'.
          }
        }
      }

      // The prime sieve: Daisy-chain filter processes together.
      func sieve() {
        ch := make(chan int)  // Create a new channel.
        go generate(ch)       // Start generate() as a subprocess.
        for {
          prime := <-ch
          fmt.Print(prime, \"\n\")
          ch1 := make(chan int)
          go filter(ch, ch1, prime)
          ch = ch1
        }
      }

      func main() {
        sieve()
      }
      ", uuid: snippet_uuid, parent_uuid: snippet_uuid, user_id: user.id, visibility: 'org', language: 'go')
    
    
    
    
    
    end
  end
end
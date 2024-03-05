# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "dropzone" # @6.0.0
pin "just-extend" # @5.1.1
pin "activestorage" # @5.2.8
pin "@rails/activestorage", to: "@rails--activestorage.js" # @7.1.3

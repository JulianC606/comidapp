# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@maslick/koder", to: "@maslick--koder.js" # @1.3.2
pin "fs" # @2.1.0
pin "path" # @2.1.0
pin "process" # @2.1.0

import Config

config :logger, :console,
  format: "[$level] $message $metadata\n",
  # metadata: [:mfa, :file, :code]
  metadata: :all

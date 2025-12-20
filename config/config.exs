import Config

config :git_ops,
  mix_project: Mix.Project.get!(),
  types: [tidbit: [hidden?: true], important: [header: "Important Changes"]],
  github_handle_lookup?: true,
  repository_url: "https://github.com/cao7113/ecli",
  version_tag_prefix: "v",
  manage_mix_version?: true,
  manage_readme_version: true

config :logger, :console,
  format: "[$level] $message $metadata\n",
  # metadata: [:mfa, :file, :code]
  metadata: :all

import Config

import_config "#{Mix.env()}.exs"

config :codepagex, :encodings, [
  :ascii,
  ~r[iso8859]iE,
  "ETSI/GSM0338"
]

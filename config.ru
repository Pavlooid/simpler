require 'rack'
require_relative 'config/environment'
require_relative 'middleware/logs'

use Logs, 'log/app.log'
run Simpler.application

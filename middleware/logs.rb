require 'logger'

class Logs

  def initialize(app, path_to_logs)
    @logger = Logger.new(Simpler.root.join(path_to_logs))
    @app = app
  end

  def call(env)
    @env = env
    status, headers, body = @app.call(env)
    @logger.info(log(status, headers, env))

    [status, headers, body]
  end

  private

  def log(status, headers, body)
    "Request: #{@env['REQUEST_METHOD']}" \
    "Handler: #{@env['simpler.controller'].class.name}##{@env['simpler.action']}" \
    "Parameters: #{@env['simpler.route_params']}" \
    "Responce: #{status} [#{headers['Content-type']}] #{@env['simpler.template']}" \
  end
end

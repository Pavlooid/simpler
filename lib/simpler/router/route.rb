module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :path, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path, params)
        @method == method && check_paths(path, params)
      end

      private

      def check_paths(path, params)    
        router_path = @path.split('/')
        request_path = path.split('/')
        return false if request_path.length != router_path.length
        router_path.each_with_index do |part, index|
          if part.start_with?(':')
            set_param(params, part, request_path[index])
          else
            return false if part != request_path[index]
          end
        end
      end

      def set_param(params, parameter, value)
        parameter = parameter.delete!(':').to_sym
        params[parameter] = value
      end
    end
  end
end

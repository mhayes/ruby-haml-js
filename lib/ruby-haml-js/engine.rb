module RubyHamlJs
  class Engine < Rails::Engine
    initializer :setup_hamljs, after: 'sprockets.environment', group: :all do |app|
      if app.assets
        self.class.install app.assets
      else
        app.config.assets.configure { |env| self.class.install env }
      end
    end

    def self.install(environment)
      if environment.respond_to?(:register_engine)
        # Sprockets 3
        environment.register_engine '.hamljs', Processor, mime_type: 'application/javascript', silence_deprecation: true
      elsif environment.respond_to?(:register_transformer)
        # Sprockets 4
        environment.register_mime_type('text/hamljs', extensions: ['.hamljs'])
        environment.register_transformer('text/hamljs', 'application/javascript', Processor)
      end
    end
  end
end

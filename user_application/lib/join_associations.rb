module JoinAssociations
  module Builder
    module_function

    def build_has_one(klass, name, options = {})
      Reflection.build(klass, :has_one, name, options)
    end

    def build_has_many(klass, name, options = {})
      Reflection.build(klass, :has_many, name, options)
    end
  end

  class Reflection
    def self.build(*args)
      new(*args).build
    end

    def initialize(klass, macro, name, options)
      @klass, @macro, @name, @options = klass, macro, name, options
    end

    attr_reader :klass, :macro, :name, :options

    def build
      join_args = build_join_args
      through_args = build_through_args

      klass.send(macro, *join_args)
      klass.send(macro, *through_args)
    end

    def build_join_args
      [join_name, join_scope, join_options].compact
    end

    def build_through_args
      [through_name, through_options]
    end

    def join_class_name
      @klass ||= derive_join_class_name
    end

    def through_class_name
      @class_name ||= derive_through_class_name
    end

    def join_name
      @join_name ||= derive_join_name
    end

    def join_options
      @join_options ||= {
        class_name: derive_join_class_name
      }
    end

    def join_scope
      @join_scope ||= derive_join_scope
    end

    def through_name
      @through_name ||= derive_through_name
    end

    def through_options
      @through_options ||= {
        through: join_name,
        source: options[:source] || name.to_s.singularize,
        class_name: derive_through_class_name
      }
    end

    private

    def derive_join_class_name
      inverse_of = options.fetch(:inverse_of).to_s.classify
      through_class_name = derive_through_class_name

      ordered_string(inverse_of, through_class_name).camelize.singularize
    end

    def derive_join_name
      inverse_of = options.fetch(:inverse_of)

      join_name = ordered_string(inverse_of, name, '_')
      join_name = scope_string(join_name, '_')
      join_name.to_sym
    end

    def derive_join_scope
      scope = options[:scope]
      scope ? proc { public_send(scope) } : nil
    end

    def derive_through_name
      options[:alias] ? options[:alias] : scope_string(name, '_').to_sym
    end

    def derive_through_class_name
      options[:class_name] ? options[:class_name].to_s.camelize : name.to_s.classify
    end

    def scope_string(name, separator = '')
      return name unless (scope = options[:scope])
      [scope, name].join(separator)
    end

    def ordered_string(a, b, separator = '')
      str_args =
        if options[:transpose]
          [b.to_s.singularize, a.to_s.pluralize]
        else
          [a, b]
        end

      str_args.join(separator)
    end
  end
end

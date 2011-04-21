module Ripple
  module Document
    module Finders
      module ClassMethods
        def find(*args)
          return find_one(args.first) unless args.size != 1 || args.first.kind_of?(Array)
          return args.first if args.first.kind_of?(Array) && args.first.empty?
          args.flatten!
          raise Ripple::DocumentNotFound, "Could not find #{@klass.name} without a key" if args.empty? || args.all?(&:blank?)
          args.map {|key| find_one(key) }
        end
      end
    end
  end
end

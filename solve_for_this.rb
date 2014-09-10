##
## Invoke with jruby solve_for_this.rb
##
require 'java'
require './code/mallet-deps.jar'
require './code/mallet.jar'

class SolveForThis 
  include Java::cc::mallet::optimize::Optimizable::ByGradientValue

  attr_accessor :parameters
    def initialize(x,y)
        @parameters = []
        @parameters[0] = x;
        @parameters[1] = y;
    end

    def getValue

        x = @parameters[0];
        y = @parameters[1];

        return -3*x*x - 4*y*y + 2*x - 4*y + 18;

    end

    def getValueGradient(gradient)

        gradient[0] = -6 * @parameters[0] + 2;
        gradient[1] = -8 * @parameters[1] - 4;

    end

    # The following get/set methods satisfy the Optimizable interface

    def getNumParameters
      return 2
    end
    
    def getParameter(i)
      return @parameters[i]
    end
    
    def getParameters(buffer)
        buffer[0] = @parameters[0];
        buffer[1] = @parameters[1];
    end

    def setParameter(i, r)
        @parameters[i] = r
    end
    
    def setParameters(newParameters)
        @parameters[0] = newParameters[0];
        @parameters[1] = newParameters[1];
    end
end

##
## The calling conventions below are hideous
## I couldn't make it work by naively calling methods (due to overloads)
## and couldn't make java_send work either....
##

solvable = SolveForThis.new(0.0,0.0)
construct = Java::cc::mallet::optimize::LimitedMemoryBFGS.java_class.constructor(Java::cc::mallet::optimize::Optimizable::ByGradientValue)
opt = construct.new_instance(solvable)
optimize_method = opt.java_class.declared_method(:optimize)
converged = optimize_method.invoke(opt)
puts converged
puts solvable.parameters


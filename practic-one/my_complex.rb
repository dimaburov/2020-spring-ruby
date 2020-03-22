class MyComplex
    def initialize(real,imaginary)
        @real=real
        @imaginary=imaginary
    end
    def to_s
        "#{@real} + i*#{@imaginary}"
    end
    def real
        @real
    end
    def imaginary
        @imaginary
    end
    def add (other)
      return  object_new=MyComplex.new(@real+other.real,@imaginary+other.imaginary)
    end
end
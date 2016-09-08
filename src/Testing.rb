class Tester

  def initialize
    resultado= Resultado.new
  end

  def corre_test(test)
    "blabla"
  end

  def corre_conjunto_de_tests(*args)
    args.each do |test|  corre_test test
    end
  end

  def correr_suite(clase)
    clase.methods(regular=true).each do |metodo|
      self.corre_test metodo
    end
  end

  def correr_metodos_de(clase, *args)
    if(args.all? {|metodo| clase.respond_to? metodo})
       self.corre_conjunto_de_tests args
    end
  end

  def uno_de_estos(*args)
    args.any? {|elem| self.eql? elem }
  end


  def entender(sym)
    self.respond_to? sym
  end

  def explotar_con (object)
    catch (self) do
      while gets
        throw self.to_sym object
      end
      return true

    end
  end
end

class Verificador

  attr_accessor :tester, :resultado

  def definir_deberia
    #defino el metodo deberia a todos los objetos
    Object.send(:define_method, (:deberia), proc { |proc| instance_eval &proc})
  end

  def definir_ser
    # Object.send(:define_method, (:ser), Proc.new do |resultado| self.eql? resultado end)
    Object.send(:define_method, (:ser), proc { |resultado|
      Proc.new do
        self.equal? resultado
      end })

  end

  def es_test?(sym)
    sym.to_s[0..11] == 'testear_que_'
  end


  def contiene_tests(una_clase)
    var = una_clase.new
    metodos = var.methods(regular=true).select do |elem|
      self.es_test? elem
    end
    not metodos.empty?
  end


  def validar(sym)
    if es_test? sym
      #testear_metodo
    end
  end

  def testear(*args)
    tamanio = args.size
    tester= Tester.new
    resultado= Resultado.new
    if(tamanio == 0)
      #corre_test(args.first)
      0
    else if (tamanio == 1)
           tester.correr_suite(args.first)
           resultado.tests_corridos = 1
           1
         else
           tester.corre_conjunto_de_tests(args[1..-1])
           2
         end
    end
  end


  def sacar_deberia
    Object.send(:undef_method, :deberia)
  end

  def initialize
    tester= Tester.new
    definir_deberia
    definir_ser
  end

end



class MiSuiteDeTests
  def testear_que_pasa_algo
    'hola'
  end

  def otro_metodo_que_no_es_un_test
  end
end

class Resultado
  attr_accessor :tests_corridos, :tests_pasados, :tests_explotados

  def initialize
    tests_corridos = 0
    tests_pasados =0
    tests_explotados =0
  end

end

class Persona
  attr_accessor :edad
end

class PersonaTest
  def testear_que_se_use_la_edad
    lean = Persona . new ( 22)
    pato = Persona . new ( 23)

  end

end
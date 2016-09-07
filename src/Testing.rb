class TADsPec

  #include Ser

  def definir_deberia
    #defino el metodo deberia a todos los objetos
    Object.send(:define_method, (:deberia), proc do |procedimiento| self.instance_eval &procedimiento end)
  end

  def definir_ser
   Object.send(:define_method, (:ser), proc do |resultado| self.eql? resultado end)
  end

  def initialize
    definir_deberia
    definir_ser
  end

  def testear(*args)
    tamanio = args.size
    if(tamanio == 0)
      'Testeando el contexto'
      0
    else
      if (tamanio == 1)
        1
      else
        2
      end
    end
  end

  def self.es_test?(sym)
    sym.to_s[0..11] == 'testear_que_'
  end

  def validar(sym)
    if es_test? sym
      #testear_metodo
    end
  end

  def sacar_deberia
    Object.send(:undef_method, :deberia)
  end


  def method_missing(sym, *args)
    if(sym.to_s.size > 3)
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

  def self.contiene_tests(una_clase)
    var = una_clase.new
    metodos = var.methods(regura=true).select do |elem|
      TADsPec.es_test? elem
    end
    not metodos.empty?
  end


end

class MiSuiteDeTests
  def testear_que_pasa_algo
    'hola'
  end

  def otro_metodo_que_no_es_un_test
  end


end
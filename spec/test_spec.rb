require 'rspec'
require_relative '../src/Testing'

describe 'TADsPec tests' do

  verificador = Verificador.new
  tester = Tester.new
  it 'cualquier objeto entiende :deberia' do
    expect(Object.respond_to? (:deberia)).to be(true)
  end

  it 'cualquier objeto entiende :ser' do
    expect(Object.respond_to? (:ser)).to be(true)
  end

  it 'se pasa el test deberia con ser' do
    leandro = Persona.new
    leandro.edad = 20

    expect(leandro.edad.deberia ser 15).to be(false)
  end

  it 'falla el test deberia con ser' do
    expect(1.deberia ser 1).to be(true)
  end

  #TODO: cambiar las aserciones de los tests!
  it 'se testea el contexto' do
      expect(verificador.testear).to be(0)
  end

  it 'se testea la suite entera' do
    expect(verificador.testear MiSuiteDeTests).to be(1)
  end

  it 'se testean solo algunos metodos de la suite' do
    expect(verificador.testear MiSuiteDeTests, (:testear_que_pasa_algo)).to be(2)
  end

  it 'es un test' do
    expect(verificador.es_test? (:testear_que_algo)).to be(true)
  end

  it 'se elimina el mensaje deberia' do
    verificador.sacar_deberia
    expect(Object.respond_to? (:deberia)).to be(false)
  end

  it 'se testea una clase con tests' do
    expect(verificador.contiene_tests MiSuiteDeTests).to be(true)
  end

  it 'se testea un test de la clase con tests' do
    verificador.testear MiSuiteDeTests, :testear_que_pasa_algo
    expect(verificador.resultado.tests_corridos).to be(1)
  end

  it 'se define el test tener_' do
    leandro = Persona.new
    leandro.deberia tener_edad 22
    expect(leandro.respond_to? (:tener_edad)).to be(true)
  end

end
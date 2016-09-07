require 'rspec'
require_relative '../src/Testing'

describe 'TADsPec tests' do

  tester = TADsPec.new
  it 'cualquier objeto entiende :deberia' do

    expect(Object.respond_to? (:deberia)).to be(true)
  end

  #TODO: cambiar las aserciones de los tests!
  it 'se testea el contexto' do
      expect(tester.testear).to be(0)
  end

  it 'se testea la suite entera' do
    expect(tester.testear 1).to be(1)
  end

  it 'se testean solo algunos metodos de la suite' do
    expect(tester.testear 1,2).to be(2)
  end

  it 'es un test' do
    expect(TADsPec.es_test? (:testear_que_algo)).to be(true)
  end

  it 'se elimina el mensaje deberia' do
    tester.sacar_deberia
    expect(Object.respond_to? (:deberia)).to be(false)
  end

  it 'se testea una clase con tests' do
    expect(TADsPec.contiene_tests MiSuiteDeTests).to be(true)

  end

end
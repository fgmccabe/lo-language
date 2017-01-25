describe "L&O Grammar", ->
  grammar = null
  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("lo-language")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.lo")

  it "parses the grammar", ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe "source.lo"

  it "tokenizes strings", ->
    {tokens} = grammar.tokenizeLine '"alpha\\(beta+4)gamma"'

    expect(tokens[0]).toEqual value: '"', scopes: ["source.lo","string.quoted.double.lo",'punctuation.definition.string.begin.lo']
    expect(tokens[1]).toEqual value: "alpha", scopes: ["source.lo","string.quoted.double.lo"]
    expect(tokens[2]).toEqual value: "\\(", scopes: ["source.lo","string.quoted.double.lo",'embedded.line.lo','punctuation.section.embedded.begin.lo']
    expect(tokens[3]).toEqual value: "beta", scopes: ["source.lo","string.quoted.double.lo",'embedded.line.lo',"source.lo",'variable.language.lo']
    expect(tokens[4]).toEqual value: "+", scopes: ["source.lo","string.quoted.double.lo",'embedded.line.lo',"source.lo",'support.operator.lo']
    expect(tokens[5]).toEqual value: "4", scopes: ["source.lo","string.quoted.double.lo",'embedded.line.lo',"source.lo",'constant.numeric.lo']
    expect(tokens[6]).toEqual value: ")", scopes: ["source.lo","string.quoted.double.lo",'embedded.line.lo','punctuation.section.embedded.end.lo']
    expect(tokens[7]).toEqual value: "gamma", scopes: ["source.lo","string.quoted.double.lo"]
    expect(tokens[8]).toEqual value: '"', scopes: ["source.lo","string.quoted.double.lo",'punctuation.definition.string.end.lo']
    expect(tokens.length).toEqual 9

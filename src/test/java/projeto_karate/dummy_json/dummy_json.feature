Feature: Testando resources da API DummyJson

Background: 
    * def base_url = 'https://dummyjson.com'
    * def product_json = read("json_product.json")

Scenario: Pegando todos os produtos
    Given url base_url
    And path '/products'
    When method get
    Then status 200
    And match $.products == '#[]'
    And match $.products == '#[30]'
    And match $.total == 100 
    And match each $.products contains { id: '#number', title: '#string', description: '#string', price: '#number'}

Scenario: Pegando um produto específico
    Given url base_url
    And path '/products/1'
    When method get
    Then status 200
    And match $.id == 1
    And match $.title == 'iPhone 9'
    And match $.description == 'An apple mobile which is nothing like apple'

Scenario: Pegando um produto inexistente (Com erro)
    Given url base_url
    And path '/products/101' 
    When method get
    Then status 404

Scenario: Usando method POST na URL errada (Com erro)
    Given url base_url
    And path '/products'
    And request product_json
    When method post
    Then status 404

Scenario: Criando um novo produto 
    Given url base_url
    And path '/products/add'
    And request product_json
    When method post
    Then status 200
    And match $.id == 101
    And match $.title == 'Redmi Note 10'
    And match $.description == 'An Android phone created by Xiaomi'

Scenario: Deletando um produto 
    Given url base_url
    And path '/products/1'
    When method delete
    Then status 200
    And match $.isDeleted == true

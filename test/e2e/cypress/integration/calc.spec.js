/// <reference types="cypress" />

context('Calc', () => {
  beforeEach(() => {
    cy.visit('http://calc-web/')
  })

  it('get the title', () => {
    cy.title().should('include', 'Calculator')
  })

  it('can type operands', () => {
    cy.get('#in-op1').clear().should('have.value', '')
      .type('5').should('have.value', '5')
    cy.get('#in-op2').clear().should('have.value', '')
      .type('-5').should('have.value', '-5')
  })

  it('can click add', () => {
    cy.get('#in-op1').clear().type('2')
    cy.get('#in-op2').clear().type('3')
    cy.get('#button-add').click()
    cy.get('#result-area').should('have.text', "Result: 5")
  })

  it('can click substract', () => {
    cy.get('#in-op1').clear().type('4')
    cy.get('#in-op2').clear().type('-4')
    cy.get('#button-substract').click()
    cy.get('#result-area').should('have.text', "Result: 8")
  })

  it('increases the history log', () => {
    cy.get('#button-add').click().click().click()
    cy.get('#history-log').children().its('length')
    .should('eq', 3)
  })


})

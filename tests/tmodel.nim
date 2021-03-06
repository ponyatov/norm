import unittest
import options

import norm/model

import models


suite "Getting table and columns from Model":
  test "Table":
    check Person.table == """"Person""""

  test "Columns":
    let
      toy = newToy(123.45)
      pet = newPet("cat", toy)
      person = newPerson("Alice", pet)

    check person.col("name") == "name"
    check pet.col("species") == "species"

    check person.cols == @["name", "pet"]
    check person.cols(force = true) == @["name", "pet", "id"]

    check person.fCol("name") == """"Person".name"""
    check pet.fCol("species") == """"Pet".species"""

    check person.rfCols == @[""""Person".name""", """"Pet".species""", """"Toy".price""", """"Toy".id""", """"Pet".id""", """"Person".id"""]
    check toy.rfCols == @[""""Toy".price""", """"Toy".id"""]

  test "Join groups":
    let
      toy = newToy(123.45)
      pet = newPet("cat", toy)
      person = newPerson("Alice", pet)

    check person. joinGroups == @[(""""Pet"""", """"Person".pet""", """"Pet".id"""), (""""Toy"""", """"Pet".favToy""", """"Toy".id""")]

#
# Copyright (c) 2015-2020 "Neo Technology,"
# Network Engine for Objects in Lund AB [http://neotechnology.com]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Attribution Notice under the terms of the Apache License 2.0
#
# This work was created by the collective efforts of the openCypher community.
# Without limiting the terms of Section 6, any Derivative Work that is not
# approved by the public consensus process of the openCypher Implementers Group
# should not be described as “Cypher” (and Cypher® is a registered trademark of
# Neo4j Inc.) or as "openCypher". Extensions by implementers or prototypes or
# proposals for change that have been documented or implemented should only be
# described as "implementation extensions to Cypher" or as "proposed changes to
# Cypher that are not yet approved by the openCypher community".
#

#encoding: utf-8

Feature: SemanticErrorAcceptance

  @NegativeTest
  Scenario: Failing when returning an undefined variable
    Given any graph
    When executing query:
      """
      MATCH ()
      RETURN foo
      """
    Then a SyntaxError should be raised at compile time: UndefinedVariable

  @NegativeTest
  Scenario: Failing when using non-constants in SKIP
    Given any graph
    When executing query:
      """
      MATCH (n)
      RETURN n
        SKIP n.count
      """
    Then a SyntaxError should be raised at compile time: NonConstantExpression

  @NegativeTest
  Scenario: Failing when using negative value in SKIP
    Given any graph
    When executing query:
      """
      MATCH (n)
      RETURN n
        SKIP -1
      """
    Then a SyntaxError should be raised at compile time: NegativeIntegerArgument

  @NegativeTest
  Scenario: Failing when using non-constants in LIMIT
    Given any graph
    When executing query:
      """
      MATCH (n)
      RETURN n
        LIMIT n.count
      """
    Then a SyntaxError should be raised at compile time: NonConstantExpression

  @NegativeTest
  Scenario: Failing when using negative value in LIMIT
    Given any graph
    When executing query:
      """
      MATCH (n)
      RETURN n
        LIMIT -1
      """
    Then a SyntaxError should be raised at compile time: NegativeIntegerArgument

  @NegativeTest
  Scenario: Failing when using floating point in LIMIT
    Given any graph
    When executing query:
      """
      MATCH (n)
      RETURN n
        LIMIT 1.7
      """
    Then a SyntaxError should be raised at compile time: InvalidArgumentType

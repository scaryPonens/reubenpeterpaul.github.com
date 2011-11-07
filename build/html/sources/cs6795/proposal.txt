Group 2 - Proposal for PSOA-to-TPTP Converter
==========================================

Introduction
-----------------
Rule Language is a main typr of formal languages for knowledge representation in
semntic web technologies.  PSOA-RuleML [PSOA11]_ is a rule language which
generalizes POSL [BoleyPSOA]_, F-Logic and W3C's RIF-BLD languages
[BoleyKifera]_, [BoleyKiferb]_.  IN PSOA-RuleML, the positional-slotted,
object-applicative (PSOA) term is introduced as a generalization of the frame
term and the class membership term in RIF-BLD, as well as the positional-slotted
term in POSL language.  The planned two-part implementation of PSOA-RuleML is
(1) convert PSOA-RuleML's syntax into TPTP format, and (2) reads and executes
the TPTP with Vampire theorem prover [#f1]_.  In this project, we are going to
implement part (1) of the overarching project.


Objectives
-------------

This project is an important part of PSOA-RuleML implementation.  The objectives
of the project is as follows:

  1. Develop a converter to translate PSOA-RuleML rule language documents into TPTP
  format documents.  The input of the converter is a document conforming to
  PSOA-RuleML presentation syntax shown in [BoleyRif]_.  The output of the
  converter is a TPTP-FOF format document.

  2. Create some test examples in PSOA-RuleML syntax and their corresponding TPTP
  format documents for testing the converter.  These examples can be further
  extended to a complete PSOA test suite in the future.

.. todo:: Include diagram we drew on Harold's white board.

Methodology
-------------

EBNF and Grammar Specification
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parser and Lexer Generation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Abstract Syntax Trees
~~~~~~~~~~~~~~~~~~~~~~

ANTLR Tree Language
~~~~~~~~~~~~~~~~~~~~


Tools
--------

RuleML API
~~~~~~~~~~~~~~~

ANTLR and AntlrWorks
~~~~~~~~~~~~~~~~~~~~~~

.. [#f1] http://www.voronkov.com/vampire.cgi

.. [BoleyRif] H. Boley, A RIF-Style Semantics for RuleML-Integrated Positional-Slotted, Object-Applicative Rules, RuleML Europe 2011, 194-211

.. [BoleyPSOA] H. Boley, POSL: An Integrated Positional-Slotted Language for Semantic Web Knowledge, http://ruleml.org/submission/ruleml-shortation.html

.. [BoleyKifera] H. Boley and M. Kifer, A Guide to the Basic Logic Dialect for Rule Interchange on the Web. IEEE Transactions on Knowledge and Data Engineering, 22(11):1593-1608

.. [BoleyKiferb] H. Boley and M. Kifer, RIF Basic Logic Dialect, http://www.w3.org/TR/rif-bld/

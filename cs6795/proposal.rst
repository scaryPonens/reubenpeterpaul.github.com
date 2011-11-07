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

Grammar Specification
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to develop a converter from PSOA-RuleML rule language into TPTP via
*translation* (or transformation).  A *program* specified in PSOA-RuleML must be
recognized and parsed into a representation that lends itself to such a
*transformation*.  This generally requires the use of a grammar specification
via specialized notation: Backus-Naur Form [#f2]_, Extended Backus-Naur Form [#f3]_ or
more less known Parsing Expression Grammar [#f4]_.

Compiler-compilers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

According to [WpCC]_, a **compiler-compiler** or **compiler generator** is a
tool that creates a parser (and lexer), an interpreter/compiler from som form of
formal description of a language and machine.  The most prevalent form of
compiler-compiler is a **parser-generator** whose input is a grammar (like those
mentioned above) of a programming language and whose output is a collection of
source code for a parser (and lexer) often used as an initial (partial) set of components
for a compiler.

[WpCC]_ also mentions an open problem, that is the "holy grail" of
compiler-compilers such that a formal grammar along with a target platforms
instruction set may be given as inputs and the result would be a *full* set of
compiler components capable of producing executable bytecode for machines
implementing the above instruction set.

Abstract Syntax Trees
~~~~~~~~~~~~~~~~~~~~~~

The result of applying a typical parser generator to a *input program* (or
*strings*) is a
**concrete syntax tree**, or **parse tree**: an ordered, rooted tree that
represents the syntactic structure of the *input* according to some formally
specified grammar.  In a parse tree, the leaves are labeled by *terminals* of the
grammar while the internal nodes are labeled as *non-terminals* of the grammar.

According to [AntlrGuide]_ and [WpCC]_ typical parser generators associate
pieces of executable code (written in a particular target language, e.g. Java, Python,
Ruby, etc.).  These pieces of code referred to as **actions** or **semantic
action routines** are executed when a particular rule of the grammar is applied
by the parser.  These routines may be used to specify the semantics of the
syntactic structure that is analyzed by the parser. 

The result of applying the generated parser with 
**semantic action routines** is an **abstract syntax tree**, or alternatively
executable code.  In this project we will concern ourselves with **abstract
syntax trees** only, such that the *transformation/translation* we intend to
perform will be done against an **AST** to produce yet another **AST** that may
be used to yield *executable* **TPTP-FOF** strings.

Tools
--------

RuleML API
~~~~~~~~~~~~~~~

.. todo:: Discuss with Alex and Sadnan the purpose of this API.

ANTLR and AntlrWorks
~~~~~~~~~~~~~~~~~~~~~~

We will be working with ANTLR, a sophisticated parser-generator tool that is
popular and used to implement language interpreters and compilers.

ANTLRWorks is a graphical user interface development environment used to
facilitate the development of grammars (in **EBNF**) by providing the researcher
with tooling for testing/debugging the generated parser, running the parser
against various inputs, running rules in isolation against various inputs,
visualizing syntax diagrams of the grammar rules, visualizing the **concrete
syntax tree** produced by applying the generated parser against inputs.

ANTLR Tree Description Language
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As mentioned above parser generators typically support **action routines** to be
executed "on-application" of a given rule, ANTLR is no exception.  Additionally,
it supports a separate mechanism for constructing **trees** using the ``->``
operator and **ANTLR treed description language**.  Using ANTLR’s tree
description language, a tree is written like this::

  ^( CLASS T ^(VARDEF int i) ^(VARDEF int j) ^(METHOD ...) ...)

This notation may also be used to recognize *subtrees*, introducing a higher
level of abstraction, more suitable for mananging complexities of translating a
PSOA-RuleML to another language such as TPTP-FOF.



.. [#f1] http://www.voronkov.com/vampire.cgi

.. [#f2] http://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form

.. [#f3] http://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_Form

.. [#f4] http://en.wikipedia.org/wiki/Parsing_expression_grammar

.. [BoleyRif] H. Boley, A RIF-Style Semantics for RuleML-Integrated Positional-Slotted, Object-Applicative Rules, RuleML Europe 2011, 194-211

.. [BoleyPSOA] H. Boley, POSL: An Integrated Positional-Slotted Language for Semantic Web Knowledge, http://ruleml.org/submission/ruleml-shortation.html

.. [BoleyKifera] H. Boley and M. Kifer, A Guide to the Basic Logic Dialect for Rule Interchange on the Web. IEEE Transactions on Knowledge and Data Engineering, 22(11):1593-1608

.. [BoleyKiferb] H. Boley and M. Kifer, RIF Basic Logic Dialect, http://www.w3.org/TR/rif-bld/

.. [WpCC] Compiler-Compiler, Wikipedia: The Free Encylopedia, http://en.wikipedia.org/wiki/Parser_generator

.. [AntlrGuide] Terrence Parr, The Definitive ANTLR Reference: Building Domain
  Specific Languages, 2007, Pragmatic Programmer, USA.


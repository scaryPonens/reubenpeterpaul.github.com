Assignment 2
===============

Part 1 - Draw DLG of RDF/XML Document
------------------------------------------

.. todo::

  This is RDF metadata about four fictitious people:

  .. code-block:: xml
    
    <?xml version="1.0"?>
    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
      xmlns:samfam="http://samplefamily.org/elements/">
      <rdf:Description rdf:about="http://www.ourhomes/john">
        <samfam:name>John Smith</samfam:name>
        <samfam:sibling rdf:resource="http://www.ourhomes/mary"/>
      </rdf:Description>
      <rdf:Description rdf:about="http://www.ourhomes/mary">
        <samfam:name>Mary Smith</samfam:name>
        <samfam:sibling rdf:resource="http://www.ourhomes/john"/>
      </rdf:Description>
      <rdf:Description rdf:about="http://www.ourhomes/babs">
        <samfam:name>Barbara Smith</samfam:name>
        <samfam:child rdf:resource="http://www.ourhomes/john"/>
        <samfam:child rdf:resource="http://www.ourhomes/mary"/>
      </rdf:Description>
      <rdf:Description rdf:about="http://www.ourhomes/herb">
        <samfam:name>Herbert Smith</samfam:name>
        <samfam:child rdf:resource="http://www.ourhomes/john"/>
        <samfam:child rdf:resource="http://www.ourhomes/mary"/>
      </rdf:Description>
    </rdf:RDF>

  Draw the directed labeled graph (DLG) that constitutes the RDF diagram of this XML element (use space below). 
  Hint: URLs, going into ovals or becoming arc labels, and texts, going into rectangles, may be arbitrarily shortened, along as they remain unique (e.g.: '.../john' or just 'john'; 'John S' or just 'JS'); namespaces can be omitted.

.. graphviz::

  digraph g {

    // Resources
    node [label="john"] john;
    node [label="mary"] mary;
    node [label="babs"] babs;
    node [label="herb"] herb;


    // Literals
    node [shape=rectangle, label="John Smith"] john_name;
    node [shape=rectangle, label="Mary Smith"] mary_name;
    node [shape=rectangle, label="Barbara Smith"] babs_name;
    node [shape=rectangle, label="Herbert Smith"] herb_name;

    // Name relationships
    john -> john_name [label="name"];
    mary -> mary_name [label="name"];
    babs -> babs_name [label="name"];
    herb -> herb_name [label="name"];

    // sibling relationships
    john -> mary [label="sibling"];
    mary -> john [label="sibling"];

    // Child relationships
    babs -> mary [label="child"];
    babs -> john [label="child"];
    herb -> mary [label="child"];
    herb -> john [label="child"];

  }

.. note::

  Above graph created manually using the following graphviz DOT language::

    digraph g {

      // Resources
      node [label="john"] john;
      node [label="mary"] mary;
      node [label="babs"] babs;
      node [label="herb"] herb;


      // Literals
      node [shape=rectangle, label="John Smith"] john_name;
      node [shape=rectangle, label="Mary Smith"] mary_name;
      node [shape=rectangle, label="Barbara Smith"] babs_name;
      node [shape=rectangle, label="Herbert Smith"] herb_name;

      // Name relationships
      john -> john_name [label="name"];
      mary -> mary_name [label="name"];
      babs -> babs_name [label="name"];
      herb -> herb_name [label="name"];

      // sibling relationships
      john -> mary [label="sibling"];
      mary -> john [label="sibling"];

      // Child relationships
      babs -> mary [label="child"];
      babs -> john [label="child"];
      herb -> mary [label="child"];
      herb -> john [label="child"];

    }


Part 2
---------

.. todo::

  Consider the following Datalog program in Prolog syntax defining a unary
  predicate or relation human:

  .. code-block:: prolog
  
    human(X) :- philosopher(X).
    human(X) :- featherless(X), biped(X).
    philosopher(X) :- dualist(X).
    dualist(john).
    biped(mary).
 

.. todo:: 

  A) Give, and very briefly explain, the result of the query human(john):
 
*yes* **because** *``john`` is a ``dualist`` and dualists are ``philosophers`` and philosophers are ``human``, therefore ``john`` is a ``human``*
 
.. todo:: 

  B) Give, and very briefly explain, the result of the query human(mary):
 
*no* **because** *``mary`` is a ``biped``, but only human if a ``biped`` and ``featherless`` however it is not known if she is a ``featherless``.  Therefore, it is not known that she is human.*

.. todo::

  c) Give the result(s) of the query:
  .. code-block::

    ?- human(Y).

Y = john
no

Part 3
-----------

.. todo::

   Using Prolog or any other logic notation, give a program that expresses that
   (1) ``ride(X,Y)`` can be proved via ``train(X,Y)`` or ``bus(X,Y)`` and (2) ``ride(X,Z)`` can be
   proved via (a) ``train(X,Y)`` or ``bus(X,Y)`` and (b), recursively, ``ride(Y,Z)``.
   Add facts representing ``train`` or ``bus`` relations in a real or fictitious region,
   mentioning a place, one of its ``train``- or ``bus``-reachable places, and one of its
   further reachable places. Show a query that asks for all of the known ``rides``,
   and a derivation using at least one occurrence of the rule (2).

   Hints: Consider to introduce an auxiliary relation for direct rides. You can
   test your program and queries in the SWI Prolog engine (variables are
   upper-cased) or in the OO jDREW POSL engine (variables are “?”-prefixed).
.. code-block:: prolog
  
  ride(X,Y) :- train(X,Y).
  ride(X,Y) :- bus(X,Y).
  ride(X,Z) :- 
    train(X,Y),
    ride(Y,Z).
  ride(X,Z) :-
    bus(X,Y),
    ride(Y,Z).

  bus(home,kings_place).
  bus(kings_place,work).
  bus(kings_place,train_station).
  train(train_station,bathurst).

.. code-block:: bash

  ?- ride(X,Y).
  X = train_station,
  Y = bathurst ;
  X = home,
  Y = kings_place ;
  X = kings_place,
  Y = work ;
  X = kings_place,
  Y = train_station ;
  X = home,
  Y = work ;
  X = home,
  Y = train_station ;
  X = home,
  Y = bathurst ;
  X = kings_place,
  Y = bathurst ;
  false.

  ?- ride(home,bathurst).
  true ;
  false.

  ?- ride(home,work).
  true ;
  false.

Part 4
--------------

.. todo::

  Consider this definition of the predicate ``goldmemgold`` (i.e., 'member
  surrounded by gold'):

  Prolog syntax::

    goldmemgold(X,[gold,X,gold|R]).
    goldmemgold(X,[Y|R]) :- goldmemgold(X,R).
   
  POSL syntax::

    goldmemgold(?X,[gold,?X,gold|?R]).
    goldmemgold(?X,[?Y|?R]) :- goldmemgold(?X,?R).
   
  You can read the two clauses as follows:
  * *X is a ``goldmemgold`` of a list whose first three elements are gold followed X
  followed by gold.*
  * *X is a ``goldmemgold`` of a list whose tail (all but the first element) is R if X
  is a goldmemgold of R.*

  Hint: You can test your answers to the following in the SWI Prolog engine
  (variables are upper-cased) or in the OO jDREW POSL engine (variables are
  “?”-prefixed).
   
  Show the results of checking for a specific goldmemgold thus:

.. code-block:: bash

  ?- goldmemgold(john,[john,gold,mary,gold,peter,gold]).
  false.

  ?- goldmemgold(mary,[john,gold,mary,gold,peter,gold]).
  true ;
  false.

.. todo::

  Show the results of enumerating goldmemgolds of a list thus
  (where “;” asks for another solution):
   
  Prolog syntax::

    ?- goldmemgold(X,[john,gold,mary,gold,peter,gold]).
   
  POSL syntax::

    ?- goldmemgold(?X,[john,gold,mary,gold,peter,gold]).

.. code-block:: bash

  ?- goldmemgold(X,[john,gold,mary,gold,peter,gold]).
  X = mary ;
  X = peter ;
  false.

.. todo::

  Briefly explain here the number of solutions found, e.g. by studying the
  expanded proof tree
  under “Solution:” in the GUI of OO jDREW.

The number of solutions found by studying the expanded proof tree under
"solution:" in the GUI of OO jDREW can be explained by the nature of how
``prolog`` iteratest through the list::

  [john,gold,mary,gold,peter,gold]

The proof tree for ``mary`` contains **one** recursive step effectively popping
``john`` off the front of the list.

The proof tree for ``peter`` contains **three** recursive steps effectively
popping ``john``, ``gold``, and ``mary`` off of the front of the list
successively until ``goldmemgold(peter,[gold,peter,gold|?R])`` succeeds.

.. todo::
  Briefly explain if it has any effect on the number of solutions that john, mary,
  and peter ‘share’ some gold?

Yes **because** if ``john``, ``mary`` and ``peter`` did not 'share' some
``gold`` the proof for ``mary`` would require **one** additional recursive step to
reduce the list ``[john,gold,gold,mary,gold,...]`` down to
``[gold,mary,gold,...]`` and an additional **two** recursive steps to 'reduce'
``[john,gold,gold,mary,gold,gold,peter,gold]`` down to ``[gold,peter,gold]``.

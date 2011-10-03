Assignment 1
==================

.. note::

  Please mark after parts :ref:`a1` and :ref:`a2`.

Part A-0
----------
.. todo:: 
  
  Do the missing leaf data for passengers cause any 
  (XML-level) issue?

No the the missing leaf data (``#PCDATA``) does not affect the xml
well-formedness.

.. _a1:

Part A-1
----------

.. todo::

  Does the repeatedly occurring ``appellation``:  

  .. code-block:: prolog

    appellation('Main St').     appellation('Fredericton').
  
  label cause a problem with respect to the unambiguous representation of 
  all parts of the taxi-ride information? 
  Hint: Is it even necessary to check whether every leaf of the tree - 
  ordered  from 37 to 12.50 - are uniquely denoted by the "path name" of node 
  labels leading to it from the taxi-ride root? What about any other repeatedly
  occurring label?

To determine potential ambiguity introduced by the repeated use of the
``appellation`` tag-label consider the following prolog system:

.. code-block:: prolog

  appellation('Main St').
  appellation('Fredericton').
  first('Peter').
  mid('C.').
  lastn('Jones').
  numbern(37).
  numbern(12).
  province('NB').

  name(X,Y,Z) :- first(X), mid(Y), lastn(Z).
  driver(W,X,Y,Z) :- numbern(W), name(X,Y,Z).
  municipality(X,Y) :- appellation(X), province(Y).
  street(X,Y) :- number(X), appellation(Y).

Backtracking in prolog against the query ``street(X,Y)`` yields the
following results:

.. code-block:: bash

  ?- ['testA2'].
  % testA2 compiled 0.00 sec, 5,624 bytes
  true.

  ?- street(X,Y).
  X = 37,
  Y = 'Main St' ;
  X = 37,
  Y = 'Fredericton' ;
  X = 12,
  Y = 'Main St' ;
  X = 12,
  Y = 'Fredericton'.

This illustrates by example that the repeated use of ``appellation`` and also
``number`` results in adding ambiguity to the representation of ``taxi-ride``.  
This problem can be dealt with via introduction of complex types, or denoting 
the leaf nodes with the path of node-labels from the root ``taxi-ride``, e.g.:

.. code-block:: prolog

  street(numbern(12), appellation('Main St')).
  municipality(appellation('Fredericton'), province('NB')).

.. _a2:

Part A-2
---------

.. todo::

  What if the nodes labeled 'appellation' would have been labeled 'name', 
  too?

Again let us consider a prolog system:

.. code-block:: prolog

  name('Main St').
  name('Fredericton').
  first('Peter').
  mid('C.').
  lastn('Jones').
  numbern(37).
  numbern(12).
  province('NB').

  name(X,Y,Z) :- first(X), mid(Y), lastn(Z).
  driver(W,X,Y,Z) :- numbern(W), name(X,Y,Z).
  municipality(X,Y) :- name(X), province(Y).
  street(X,Y) :- number(X), name(Y).

Backtracaking in prolog REPL against the query ``street`` and ``driver``
yields the following results:

.. code-block:: prolog

  ?- consult('testA2b').
  % testA2b compiled 0.00 sec, 5,096 bytes
  true.


  ?- street(X,Y).
  X = 37,
  Y = 'Main St' ;
  X = 37,
  Y = 'Fredericton' ;
  X = 12,
  Y = 'Main St' ;
  X = 12,
  Y = 'Fredericton'.

  ?- driver(W,X,Y,Z).
  W = 37,
  X = 'Peter',
  Y = 'C.',
  Z = 'Jones'.
  W = 12,
  X = 'Peter',
  Y = 'C.',
  Z = 'Jones'.

The result is the same as above (:ref:`a1`).  ``Node-labelled`` paths are still
required to denotate the ``name`` tags used by ``street`` and ``municipality``
nodes.  While the rule for ``name`` satisfies the complex conditions for
separating the parts of an individuals name.

Part A-3 - Relabeling of tree in Prolog
----------------------------------------------

.. code-block:: prolog

  carnumber(37).
  firstname('Peter').
  middlename('C.').
  lastname('Jones').
  date('9/27'). 
  streetnumber(12).
  streetname('Main St').
  municipalityname('Fredericton').
  provincename('NB').
  fare(12.50).

  taxiride(W,X,Y,Z,D,E,F,G,H,I) :- 
    driver(W,X,Y,Z), 
    passengers, 
    transportinformation(D,E,F,G,H,I).

  driver(W,X,Y,Z) :- carnumber(W), fullname(X,Y,Z).

  fullname(X,Y,Z) :- firstname(X), middlename(Y), lastname(Z).

  transportinformation(D,E,F,G,H,I) :- date(D), destination(E,F,G,H),
  fare(I).

  destination(E,F,G,H) :- street(E,F), municipality(G,H).

  street(X,Y) :- streetnumber(X), streetname(Y).

  municipality(X,Y) :- municipalityname(X), provincename(Y).

.. _b1:

Part B-1 - Well formed XML element from :ref:`a1`
--------------------------------------------------

.. code-block:: xml
  
  <?xml version="1.0" ?> 
  <taxi-ride>
    <driver>
      <number>37</number>
      <name>
        <first>Peter</first>
        <mid>C.</mid>
        <last>Jones</last>
      </name>
    </driver>
    <passengers />
    <tranport-information>
      <date>9/27</date>
      <street>
        <number>12</number>
        <appellation>Main St</appellation>
      </street>
      <municipality>
        <appellation>Fredericton</appellation>
        <province>NB</province>
      </municipality>
      <fare>
        12.50
      </fare>
    </tranport-information>
  </taxi-ride>

*Yes*, a well formed XML instance can be given for :ref:`a1`

.. _b2:

Part B-2 - Well formed XML element from :ref:`a2`
--------------------------------------------------

.. code-block:: xml

  <?xml version="1.0" ?> 
  <taxi-ride>
    <driver>
      <number>37</number>
      <name>
        <first>Peter</first>
        <mid>C.</mid>
        <last>Jones</last>
      </name>
    </driver>
    <passengers />
    <tranport-information>
      <date>9/27</date>
      <street>
        <number>12</number>
        <name>Main St</name>
      </street>
      <municipality>
        <name>Fredericton</name>
        <province>NB</province>
      </municipality>
      <fare>
        12.50
      </fare>
    </tranport-information>
  </taxi-ride>

*Yes*, a well formed XML instance can be given for :ref:`a2`

.. _b3:

Part B-3 - XML instance of relabeling
-----------------------------------------

.. code-block:: xml

  <taxiride>
    <driver>
      <carnumber>37</carnumber>
      <fullname>
        <firstname>Peter</firstname>
        <middlename>C.</middlename>
        <lastname>Jones</lastname>
      </fullname>
    </driver>
    <passengers />
    <transportinformation>
      <date>9/27</date>
      <destination>
        <street>
          <streetnumber>12</streetnumber>
          <streetname>Main St</streetname>
        </street>
        <municipality>
          <municipalityname>Fredericton</municipalityname>
          <provincename>NB</provincename>
        </municipality>
      </destination>
      <fare>12.50</fare>
    </transportinformation>
  </taxiride>

Part C - Prolog equivalent term of :ref:`b3`
--------------------------------------------------

.. code-block:: prolog

  taxiride(
    driver(
      carnumber(37),
      fullname(
        firstname('Peter'),
        middlename('C.'),
        lastname('Jones'))),
    passengers,
    transportinformation(
      date('9/27'),
      destination(
        street(
          streetnumber(12),
          streetname('Main St')),
        municipality(
          municipalityname('Fredericton'),
          provincename('NB'))),
      fare(12.50))).

Part D-1 - DTD schema for :ref:`a1`
-----------------------------------

.. code-block:: xml

  <!ELEMENT taxi-ride             (driver,passengers,transport-information)>
  <!ELEMENT driver                (number,name)>
  <!ELEMENT name                  (first,mid,last)>
  <!ELEMENT number                (#PCDATA)>
  <!ELEMENT first                 (#PCDATA)>
  <!ELEMENT mid                   (#PCDATA)>
  <!ELEMENT last                  (#PCDATA)>
  <!ELEMENT passengers            (#PCDATA)>
  <!ELEMENT transport-information (date,destination,fare)>
  <!ELEMENT date                  (#PCDATA)>
  <!ELEMENT destination           (street,municipality)>
  <!ELEMENT street                (number,appellation)>
  <!ELEMENT municipality          (appellation,province)> 
  <!ELEMENT appellation           (#PCDATA)>
  <!ELEMENT province              (#PCDATA)>

It is possible to write a DTD that precisely describe :ref:`a1` and :ref:`b1` since when DTD's are designed/applied
semantics are not considered only the structure of the ``DOM``-tree is being restricted.

Part D-2 - DTD schema for :ref:`a2`
-------------------------------------

.. code-block:: xml
  
  <!ELEMENT taxi-ride             (driver,passengers,transport-information)>
  <!ELEMENT driver                (number,name)>
  <!ELEMENT name                  ((first,mid,last)|#PCDATA)>
  <!ELEMENT number                (#PCDATA)>
  <!ELEMENT first                 (#PCDATA)>
  <!ELEMENT mid                   (#PCDATA)>
  <!ELEMENT last                  (#PCDATA)>
  <!ELEMENT passengers            (#PCDATA)>
  <!ELEMENT transport-information (date,destination,fare)>
  <!ELEMENT date                  (#PCDATA)>
  <!ELEMENT destination						(street,municipality)>
  <!ELEMENT street                (number,name)>
  <!ELEMENT municipality          (name,province)> 
  <!ELEMENT province              (#PCDATA)>
  <!ELEMENT fare									(#PCDATA)>

It is not possible to write a DTD that describes :ref:`a1` or :ref:`b1` since ``((first,mid,last)|#PCDATA)`` introduces ambiguity into 
the structure and is not permitted as a valid DTD syntax.

Part D-3 - DTD schema for :ref:`a3`
-------------------------------------

.. code-block:: xml

  <!ELEMENT taxiride								(driver,passengers,transportinformation)>
  <!ELEMENT driver									(carnumber,fullname)>
  <!ELEMENT carnumber								(#PCDATA)>
  <!ELEMENT fullname								(firstname,middlename,lastname)>
  <!ELEMENT firstname								(#PCDATA)>
  <!ELEMENT middlename							(#PCDATA)>
  <!ELEMENT lastname								(#PCDATA)>
  <!ELEMENT passengers							(#PCDATA)>
  <!ELEMENT transportinformation		(date,destination,fare)>
  <!ELEMENT date										(#PCDATA)>
  <!ELEMENT destination							(street,municipality)>
  <!ELEMENT street									(streetnumber,streetname)>
  <!ELEMENT streetnumber						(#PCDATA)>
  <!ELEMENT streetname							(#PCDATA)>
  <!ELEMENT municipality						(municipalityname,provincename)>
  <!ELEMENT municipalityname				(#PCDATA)>
  <!ELEMENT provincename						(#PCDATA)>
  <!ELEMENT fare										(#PCDATA)>
  
The :ref:`b3`-element is *Structurally* valid w.r.t. to the above DTD.

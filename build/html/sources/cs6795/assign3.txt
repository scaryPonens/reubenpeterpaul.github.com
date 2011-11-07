Assignment 3
=================

Part 1
--------

.. todo:: 

  1. This is a DTD for simple (almost natural-language) 'forward' rules and facts:
          
  .. code-block:: xml

    <!ELEMENT forward    ((rule | fact)*)>
    <!ELEMENT rule          (if, then)>
    <!ELEMENT fact          (#PCDATA)>
    <!ELEMENT if             (#PCDATA)>
    <!ELEMENT then         (#PCDATA)>
             
  a) Are the following XML elements valid with respect to this DTD
  (write "yes" or "no" behind them)?

.. code-block:: xml

  <forward> </forward> 
  <!-- YES -->

  <forward> the weather </forward> 
  <!-- NO -->

  <forward> 
    <fact> it snows </fact> 
  </forward> 
  <!-- YES -->

  <forward> 
    <rule> if it rains then the road gets wet </rule> 
  </forward> 
  <!-- NO -->

  <forward>
    <rule>
      <if> it rains </if> 
      <then> the road gets wet </then>
    </rule>
  </forward>
  <!-- YES -->

  <forward>
    <fact> it rains </fact>
    <rule>
      <if> it rains </if>
      <then> the road gets wet </then>
    </rule>
  </forward>
  <!-- YES -->

.. todo::

  b) Consider these XML elements for 'forward' (p => c) and 'backward' (c <= p) rules:

  .. code-block:: xml

    <forward> 
      <rule> 
        <if> p </if> 
        <then> c </then> 
      </rule> 
    </forward>
    
    <backward> 
      <rule> 
        <conc> c </conc> 
        <prem> p </prem> 
      </rule> 
    </backward>

  Inductively complete this XML DTD (write into the "..." lines) for
  'backward' rules and facts:

.. code-block:: xml

  <!ELEMENT backward    ((rule|fact)*)>
  <!ELEMENT rule             (conc, prem)>
  <!ELEMENT fact           (#PCDATA)>
  <!ELEMENT conc           (#PCDATA)>
  <!ELEMENT prem           (#PCDATA)>

Part 2
--------------
.. todo::

  Complete the following XSLT template – by just filling in the "..." versions
  – for the (XML-to-XML) transformation of 'forward' rules and facts into 
  'backward' rules and facts:

.. code-block:: xml

  <xsl:template match="forward">
    <backward>
      <xsl:apply-templates/>
    </backward>
  </xsl:template>

  <xsl:template match="rule">
    <rule>
      <conc><xsl:value-of select="then"/></conc>
      <prem><xsl:value-of select="if"/></prem>
    </rule>
  </xsl:template>

  <xsl:template match="fact">
    <fact>
      <xsl:value-of select="."/>
    </fact>
  </xsl:template>

Transformation inversion?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. todo::

  Could this transformation be 'inverted' mapping 'backward' rules and facts
  into 'forward' rules and facts without information loss (write in "yes"
  or "no" here)?

Yes.

Part 3
------------

Again consider the following Datalog program in Prolog syntax:

.. code-block:: prolog

  human(X) :- philosopher(X).
  human(X) :- featherless(X), biped(X).
  philosopher(X) :- dualist(X).
  dualist(john).
  biped(mary).

.. todo::

  a) Give its grounding (consistently replacing variables by constants in each rule):

.. code-block:: prolog 

  human(john) :- philosopher(john).
  human(mary) :- philosopher(mary).
  human(john) :- featherless(john), biped(john).
  human(mary) :- featherless(mary), biped(mary).
  philosopher(john) :- dualist(john).
  philosopher(mary) :- dualist(mary).
  dualist(john).
  biped(mary).


.. todo::

  .. note::

    Shortcut of the grounded program:

      .. code-block:: prolog
        
        h1 :- p1.
        h2 :- p2.
        h1 :- f1, b1.
        h2 :- f2, b2.
        p1 :- d1.
        p2 :- d2.
        d1.
        b2.

      M = {d1,b2,p1,h1}

  b) Construct its Least Herbrand Model by fixpoint iteration (starting with the set of facts, applying the rules bottom-up to add new facts, etc., until the set no longer changes):

Fixpoint iteration:

* Step 1:

  M0 = {d1, b2}

* Step 2:

  M1 = {d1, b2} + {p1}

* Step 3:

  M2 = {d1, b2, p1} + {h1}

Least Herbrand Model is: M = {dualist(john), biped(mary), philosopher(john), human(john)}

Part 4
------------

.. todo::

  Using a knowledge base with the following facts and rules about fictitious
  people, employ OO jDREW to query their represented social network. 

  .. note:: see Figure below.

  .. code-block:: prolog

    knows_from_highschool(Mary, John).

    knows_from_highschool(John, Peter).

    knows_from_university(Peter, Cora).

    knows_from_university(Cora, Gisele).


    knows(?X, ?Y) :- knows_from_highschool(?X, ?Y).

    knows(?X, ?Y) :- knows_from_university(?X, ?Y).


    knows_trans(?X, ?Y) :- knows(?X, ?Y).

    knows_trans(?X, ?Y) :-  knows(?X, ?Z),
    knows_trans(?Z, ?Y).


  Give all results of the following
  (top-down) queries employing OO jDREW TD:

.. figure:: images/a3p4.png
  :scale: 80 %

  Screenshot of the knowledge base entered into OO jDREW Top-Down Engine.


knows(Mary, John)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: images/a3p4q1.jpg
  :scale: 80 %

knows(Mary, ?Whom)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: images/a3p4q2.png
  :scale: 80 %
  
knows(?Who, ?Whom)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

See following 4 screen shots.

.. figure:: images/a3p4q3.png
  :scale: 80 %

--

.. figure:: images/a3p4q3_2.png
  :scale: 80 %

--

.. figure:: images/a3p4q3_3.png
  :scale: 80 %

--

.. figure:: images/a3p4q3_4.png
  :scale: 80 %

knows_trans(Mary, John)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: images/a3p4q4.png
  :scale: 80 %

knows_trans(Mary, ?Whom)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

See following 4 screen shots.

.. figure:: images/a3p4q5_1.png
  :scale: 80 %

--

.. figure:: images/a3p4q5_2.png
  :scale: 80 %
--

.. figure:: images/a3p4q5_3.png
  :scale: 80 %

--

.. figure:: images/a3p4q5_4.png
  :scale: 80 %

knows_trans(?Who, ?Whom)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

See following 10 Screen shots.

.. figure:: images/a3p4q6_1.png
  :scale: 80 %

--

.. figure:: images/a3p4q6_2.png
  :scale: 80 %

--

.. figure:: images/a3p4q6_3.png
  :scale: 80 %

---

.. figure:: images/a3p4q6_4.png
  :scale: 80 %

--

.. figure:: images/a3p4q6_5.png
  :scale: 80 %

--

.. figure:: images/a3p4q6_6.png
  :scale: 80 %

--

.. figure:: images/a3p4q6_7.png
  :scale: 80 %

---

.. figure:: images/a3p4q6_8.png
  :scale: 80 %

--

.. figure:: images/a3p4q6_9.png
  :scale: 80 %

--

.. figure:: images/a3p4q6_10.png
  :scale: 80 %

.. todo:: Give all results of the (bottom-up) generation employing OO jDREW BU:

.. figure:: images/a3p4bu.png

Top-down and Bottom-up correspondence
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. todo:: To which (top-down) query does the (bottom-up) generation correspond?

.. code-block:: prolog

  knows_trans(?Who,?Whom).

.. todo:: Briefly explain this correspondence.

Since bottom-up generation involves iteratively/recursively finding all grounded
atoms, i.e. the least Herbrand model (``M``), the ``knows_trans(X,Y).`` transitive query
will essentially solve the ``M`` if allowed to search until all solutions are
found.


Part 5
-----------------

.. todo::

  Construct a small ontology with a class Public Transport that has four indirect
  subclasses, Bus, Streetcar, Metro, and Train. Consider Bus and Streetcar value
  restriction properties “borne Street”; Streetcar, Metro, and Train value
  restriction properties “borne Rail”; a Metro exists restriction property “level
  Subsurface”; for all four classes, value restriction properties “carry Person”.
  Introduce two intermediate classes which abstract shared property restriction
  classes, give them (meaningful) names, and add their subclass relationships.
  Introduce all property restriction classes at the highest possible levels.
  Introduce Metro instances m1 and m2, Train instance t, and Person instance p.
  Represent the facts that m1 and m2 carry p, and t carries p.

  Write all property restriction classes that can be derived for subclasses, here:

* borneStreet all StreetTransport
* borneRail all RailTransport
* levelSubsurface some Metro
* carryPerson some Public_transport

Part 5 A
~~~~~~~~~~~~~

Draw a diagram for the ontology.
Hint: Plan to best use the space below.
Hint: Alternatively, you can model everything in the Protégé ontology editor and
get the diagram from its Jambalaya tab (attach a printout).

.. figure:: images/onto.jpg
  :scale: 80 %

  Ontology diagram.

Part 5 B
~~~~~~~~~~~~~~~~

ABox
********

{m1:Metro, m2:Metro, t:Train, p:Person} 

TBox
***********

(see attached sheet.)

Part 5 C
~~~~~~~~~~~~~~~

There are no cases of *direct* multiple inheritance in my model.  However, should I (for
example) have abstracted ``RailTransport`` to the level of
``Public_transport`` then ``Metro`` and ``Train`` would inherit from both
``Public_transport`` and ``RailTransport``.

However, there are cases of *inherited anonymous classes*, for example:

Metro and Train both inherit from ``borneRail only RailTransport`` and
``carryPerson only Public_transport`` (alos Metro inherits from
``levelSubsurface some Metro``).

Bus and Streetcar inherit from ``borneStreet only StreetTransport`` and
``carryPerson only Public_transport``.

``RailTransport`` inherits from ``Public_transport`` and ``borneRail only
RailTransport``.

``StreetTransport`` inherits from ``Public_transport`` and ``borneStreet only
StreetTransport``.

``Public_transport`` inherits from ``carryPerson only Public_transport`` and
``Thing``.

The reasoning tasks performed on the created ontology was the Pellet and Hermit
plugins for the Protege Owl 4 framework.  *(There did not appear to be anything
new learned by starting the mentioned reasoner.  Protege is a very complicated
tool and the interface is unintuitive, which is also reflected in the
documentation.)*

However the key reasoning tasks done by the above reasoners based on the
tableaux algorithm (namely Pellet) include:

* Satisfiability
* Instance checking
* Concept satisfiability
* Retrieval
* Concept Subsumption
* and Equivalence

Assignment 1
==================

Part A-0
----------
.. todo:: 
  
  Do the missing leaf data for passengers cause any 
  (XML-level) issue?

No the the missing leaf data (``#PCDATA``) does not affect the xml
well-formedness.

Part A-1
----------

.. todo::

  Does the repeatedly occurring appellation label cause a problem with 
  respect to the unambiguous representation of all parts of the taxi-ride 
  information? 
  Hint: Is it even necessary to check whether every leaf of the tree - 
  ordered  from 37 to 12.50 - is uniquely denoted by the "path name" 
  of node labels leading to it from the taxi-ride root? What about any 
  other repeatedly occurring label?

The repeatedly occuring ``appellation`` label causes a problem with respect
to unambiguous representation since it becomes necessary to trace the 
parent nodes in order determine the semantics of the leaf nodes, e.g.
it is not possible to determine that ``appellation - "Main St"`` refers 
``street`` while ``appellation - "Fredericton"`` refers to a ``city``
without the ``city`` and ``street`` labels.

Part A-2
---------

.. todo::

  What if the nodes labeled 'appellation' would have been labeled 'name', 
  too?

If ``appellation`` were labeled ``name`` also, the ambiguity would compound
since ``name`` is more complex than ``appellation`` and also the name

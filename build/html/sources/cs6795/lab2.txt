Lab 2 - Generate RDF Graph
==============================

.. todo::

  Go to the `W3C RDF Validation Service <http://www.w3.org/RDF/Validator/>`_
  Copy and edit an RDF serialization of your choice over the example in the text field or just use the example itself, at “Display Result Options:” select “Triples and Graph”, and Hit the 'Parse RDF:' button.

.. note::

  I used the following RDF/XML document:

  .. code-block:: xml

    <?xml version="1.0"?>
    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
      xmlns:a="http://www.w3.org/2001/svgRdf/axsvg-schema.rdf#">
      <rdf:Description rdf:about="#MyList">
        <a:consistsOf rdf:parseType="Collection">
          <rdf:Description rdf:about="#a"/>
          <rdf:Description rdf:about="#b"/>
          <rdf:Description rdf:about="#c"/>
          <rdf:Description rdf:about="#d"/>
        </a:consistsOf>
      </rdf:Description>
    </rdf:RDF>

The following graph was generated:

.. figure:: images/graph.png
  :scale: 40%
  :alt: generated RDF graph.

  The result of parsing the above RDF/XML document and generating a graph
  depicting the a ``Lisp`` style ``list``.

Lab 1 - Create your own XML DTD, XSD, and RNC or RNG
=====================================================

.. todo::

  Consider these examples of XML documents for clause sets consisting of zero or
  more facts f (Prolog: ``f.``) and zero or more 'backward' rules c <- p 
  (Prolog: ``c :- p.``), in any order ("myurl" will be replaced as explained below):

  .. code-block:: xml

    <?xml version="1.0" standalone="no"?>
    <!DOCTYPE clauses SYSTEM "myurl">
     <clauses>
        <fact> f </fact>
        <rule> <conc> c </conc> <prem> p </prem> </rule>
     </clauses>
     
    <?xml version="1.0" standalone="no"?>
    <!DOCTYPE clauses SYSTEM "myurl">
    <clauses>
        <rule> <conc> c1 </conc> <prem> p1 </prem> </rule>
        <fact> f1 </fact>
        <rule> <conc> c2 </conc> <prem> p2 </prem> </rule>
        <fact> f2 </fact>
        <fact> f3 </fact>
    </clauses>
     
  Inductively complete this XML DTD (overwrite the "..." lines) for such clause sets:

  .. code-block:: xml

    <!ELEMENT clauses   (................)>
    <!ELEMENT rule   (................)>
    <!ELEMENT fact    (#PCDATA)>
    <!ELEMENT ........    (................)>
    <!ELEMENT ........    (................)>

DTD
--------------

.. code-block:: xml

  <!ELEMENT clauses (fact|rule)*>
  <!ELEMENT rule		(conc,prem)>
  <!ELEMENT fact		(#PCDATA)>
  <!ELEMENT conc		(#PCDATA)>
  <!ELEMENT prem		(#PCDATA)>

XSD
------------

.. code-block:: xml

  <?xml version="1.0"?>
  <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xs:element name="clauses">
      <xs:complexType>
        <xs:sequence>
          <xs:choice maxOccurs="unbounded">
            <xs:element ref="rule"/>
            <xs:element ref="fact"/>
          </xs:choice>
        </xs:sequence>
      </xs:complexType>
    </xs:element>
    <xs:element name="rule">
      <xs:complexType>
        <xs:sequence>
          <xs:element ref="conc"/>
          <xs:element ref="prem"/>
        </xs:sequence>
      </xs:complexType>
    </xs:element>
    <xs:element name="fact" type="xs:string"/>
    <xs:element name="conc" type="xs:string"/>
    <xs:element name="prem" type="xs:string"/>
  </xs:schema>
  
RelaxNG
----------------

Compact syntax:

::

  default namespace = ""

  start = clauses
  clauses = element clauses {
    (element rule {
      (element conc {xsd:string},
      element prem {xsd:string})}
    | (element fact {xsd:string}))*}
   
.. note::

  I used `trang <http://www.thaiopensource.com/relaxng/trang.html>`_ to transform
  RelaxNG compact syntax into xml-based syntax.

XML syntax:

.. code-block:: xml

  <?xml version="1.0" encoding="UTF-8"?>
  <grammar ns="" xmlns="http://relaxng.org/ns/structure/1.0" datatypeLibrary="http://www.w3.org/2001/XMLSchema-datatypes">
    <start>
      <ref name="clauses"/>
    </start>
    <define name="clauses">
      <element name="clauses">
        <zeroOrMore>
          <choice>
            <element name="rule">
              <element name="conc">
                <data type="string"/>
              </element>
              <element name="prem">
                <data type="string"/>
              </element>
            </element>
            <element name="fact">
              <data type="string"/>
            </element>
          </choice>
        </zeroOrMore>
      </element>
    </define>
  </grammar>
  
.. note::

  To validate the above sample instances I used `xmllint - command line XML tool <http://xmlsoft.org/xmllint.html>`_
  to parse and typecheck/validate:

  .. code-block:: bash

    xmllint --noout --schema http://reubenpeterpaul.github.com/lab1/XSD/clauses.xsd clauses-instance.xml
    xmllint --noout --dtdvalid http://reubenpeterpaul.github.com/lab1/DTD/clauses.dtd clauses-instance.xml
    trang clauses.rnc clauses.rng
    xmllint --noout --relaxng clauses.rng clauses-instance.xml

.. note::

  I also used my own custom `XML catalog file
  <http://www.sagehill.net/docbookxsl/WriteCatalog.html>`_:

  .. code-block:: xml
  
    <?xml version="1.0"?>
    <!DOCTYPE catalog
    PUBLIC "-//OASIS/DTD Entity Resolution XML Catalog V1.0//EN"
    "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
    <catalog
    xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">

    ...
    
    <system
    systemId="http://reubenpeterpaul.github.com/lab1/DTD/clauses.dtd"
    uri="/home/peter-paulr/.laboratory/cs6795/lab1/clauses.dtd"
    />

    <system
    systemId="http://reubenpeterpaul.github.com/lab1/XSD/clauses.xsd"
    uri="/home/peter-paulr/.laboratory/cs6795/lab1/clauses.xsd"
    />

    </catalog>


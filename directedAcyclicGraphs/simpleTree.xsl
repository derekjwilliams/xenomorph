<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="bajaObjectGraph">
    <graphml xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://graphml.graphdrawing.org/xmlns       http://graphml.graphdrawing.org/xmlns/1.0/graphml.xsd">
      <key id="n" for="node" attr.name="n" attr.type="string"/>
      <key id="m" for="node" attr.name="m" attr.type="string"/>
      <key id="v" for="node" attr.name="v" attr.type="string"/>
      <key id="f" for="node" attr.name="f" attr.type="string"/>
      <key id="h" for="node" attr.name="h" attr.type="string"/>
      <key id="t" for="node" attr.name="t" attr.type="string"/>
      <key id="c" for="node" attr.name="c" attr.type="string"/>
      <key id="x" for="node" attr.name="x" attr.type="string"/>
      <key id="weight" for="edge" attr.name="weight" attr.type="double"/>
      <graph edgedefault="directed">
        <xsl:apply-templates select="p"/>
      </graph>
    </graphml>
  </xsl:template>
  <xsl:template match="p">
    <xsl:variable name="sourceId" select="generate-id(.)"/>
    <xsl:if test="(parent::*) and (child::*)">
      <xsl:for-each select="p">
        <xsl:variable name="childId" select="generate-id(.)"/>
        <xsl:variable name="edgeEnd" select="translate($childId, translate($childId,'0123456789',''), '')"/>
        <xsl:variable name="edgeId" select="concat($sourceId, $edgeEnd)"/>
        <edge label="contains" id="{$edgeId}" source="{$sourceId}" target="{$childId}">
          <xsl:element name="data">
            <xsl:attribute name="key">weight</xsl:attribute>
            <xsl:text>1.0</xsl:text>
          </xsl:element>
        </edge>
      </xsl:for-each>
    </xsl:if>
    <!-- TODO remove redundant value-of, should be a one liner -->
    <node id="{$sourceId}">
      <xsl:if test="@n">
        <xsl:element name="data"><xsl:attribute name="key">n</xsl:attribute><xsl:value-of select="@n"/></xsl:element>
      </xsl:if>
      <xsl:if test="@m">
        <xsl:element name="data"><xsl:attribute name="key">m</xsl:attribute><xsl:value-of select="@m"/></xsl:element>
      </xsl:if>
      <xsl:if test="@v">
        <xsl:element name="data"><xsl:attribute name="key">v</xsl:attribute><xsl:value-of select="@v"/></xsl:element>
      </xsl:if>
      <xsl:if test="@f">
        <xsl:element name="data"><xsl:attribute name="key">f</xsl:attribute><xsl:value-of select="@f"/></xsl:element>
      </xsl:if>
      <xsl:if test="@h">
        <xsl:element name="data"><xsl:attribute name="key">h</xsl:attribute><xsl:value-of select="@h"/></xsl:element>
      </xsl:if>
      <xsl:if test="@t">
          <xsl:element name="data"><xsl:attribute name="key">t</xsl:attribute><xsl:value-of select="@t"/></xsl:element>
      </xsl:if>
      <xsl:if test="@c">
        <xsl:element name="data"><xsl:attribute name="key">c</xsl:attribute><xsl:value-of select="@c"/></xsl:element>
      </xsl:if>
      <xsl:if test="@x">
        <xsl:element name="data"><xsl:attribute name="key">c</xsl:attribute><xsl:value-of select="@x"/></xsl:element>
      </xsl:if>
    </node>
    <xsl:apply-templates/>
  </xsl:template>
</xsl:stylesheet>

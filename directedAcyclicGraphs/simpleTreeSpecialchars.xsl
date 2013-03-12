<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="no" method="xml"/>
  <xsl:strip-space elements="graph"/>
  <xsl:variable name="hex2ascii-array">
    <i ref="$20">
      <xsl:text> </xsl:text>
    </i>
    <i ref="$21">!</i>
    <i ref="$22">"</i>
    <i ref="$23">#</i>
    <i ref="$24">$</i>
    <i ref="$25">%</i>
    <i ref="$28">(</i>
    <i ref="$29">)</i>
    <i ref="$2A">*</i>
    <i ref="$2B">+</i>
    <i ref="$2C">,</i>
    <i ref="$2D">-</i>
    <i ref="$2E">.</i>
    <i ref="$2F">/</i>
  </xsl:variable>
  <xsl:template match="bajaObjectGraph">
    <graphml xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://graphml.graphdrawing.org/xmlns       http://graphml.graphdrawing.org/xmlns/1.0/graphml.xsd">
      <key id="c" for="node" attr.name="c" attr.type="string"/>
      <key id="n" for="node" attr.name="n" attr.type="string"/>
      <key id="m" for="node" attr.name="m" attr.type="string"/>
      <key id="t" for="node" attr.name="t" attr.type="string"/>
      <key id="h" for="node" attr.name="h" attr.type="string"/>
      <key id="f" for="node" attr.name="f" attr.type="string"/>
      <key id="sf" for="node" attr.name="sf" attr.type="string"/>
      <key id="v" for="node" attr.name="v" attr.type="string"/>
      <key id="weight" for="edge" attr.name="weight" attr.type="double"/>
      <graph edgedefault="directed">
        <xsl:apply-templates select="p"/>
      </graph>
    </graphml>
  </xsl:template>
  <xsl:template match="text()"/>
  <xsl:template match="p">
    <xsl:variable name="t_value" select="@t"/>
    <xsl:variable name="sourceId" select="generate-id(.)"/>
    <xsl:if test="(parent::*) and (child::*) and (contains($t_value,'Capacity'))">
      <xsl:for-each select="p">
        <xsl:variable name="childId" select="generate-id(.)"/>
        <xsl:variable name="edgeEnd" select="translate($childId, translate($childId,'0123456789',''), '')"/>
        <xsl:variable name="edgeId" select="concat($sourceId, $edgeEnd)"/>
        <edge label="contains" id="{$edgeId}" source="{$sourceId}" target="{$childId}"/>
      </xsl:for-each>
    </xsl:if>
    <xsl:variable name="parent_t_value" select="./../@t"/>
    <xsl:if test="contains($t_value,'Capacity') or contains($parent_t_value,'Capacity')">
      <node id="{$sourceId}">
        <xsl:if test="@c">
          <xsl:element name="data">
            <xsl:attribute name="key">c</xsl:attribute>
            <xsl:value-of select="@c"/>
          </xsl:element>
        </xsl:if>
        <xsl:if test="@n">
          <xsl:variable name="nVal">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:element name="data">
            <xsl:attribute name="key">n</xsl:attribute>
            <xsl:call-template name="replacehex">
              <xsl:with-param name="index" select="0"/>
              <xsl:with-param name="val" select="@n"/>
            </xsl:call-template>
            <!--<xsl:value-of select="translate(@n,'$20', ' ')"/>-->
          </xsl:element>
        </xsl:if>
        <xsl:if test="@m">
          <xsl:element name="data">
            <xsl:attribute name="key">m</xsl:attribute>
            <xsl:value-of select="@m"/>
          </xsl:element>
        </xsl:if>
        <xsl:if test="@t">
          <xsl:element name="data">
            <xsl:attribute name="key">t</xsl:attribute>
            <xsl:value-of select="@t"/>
          </xsl:element>
        </xsl:if>
        <xsl:if test="@f">
          <xsl:element name="data">
            <xsl:attribute name="key">f</xsl:attribute>
            <xsl:value-of select="@f"/>
          </xsl:element>
        </xsl:if>
        <xsl:if test="@h">
          <xsl:element name="data">
            <xsl:attribute name="key">h</xsl:attribute>
            <xsl:value-of select="@h"/>
          </xsl:element>
        </xsl:if>
        <xsl:if test="@x">
          <xsl:element name="data">
            <xsl:attribute name="key">sf</xsl:attribute>
            <xsl:value-of select="@sf"/>
          </xsl:element>
        </xsl:if>
        <xsl:if test="@v">
          <xsl:element name="data">
            <xsl:attribute name="key">v</xsl:attribute>
            <xsl:value-of select="translate(@v,'$20', ' ')"/>
          </xsl:element>
        </xsl:if>
      </node>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template name="replacehex">
    <xsl:param name="val"/>
    <xsl:value-of select="$val"/>
      <xsl:variable name="val1" select="translate($val,'$20', ' ')"/>
      <xsl:value-of select="$val1">
   </xsl:value-of>
  </xsl:template>
</xsl:stylesheet>

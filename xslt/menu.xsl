<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:menu="https://morsor.github.io/xml/xsd/menu.xsd">

<xsl:template match="menu:menu">
  <xsl:call-template name="menuRenderer"><xsl:with-param name="node" select="." /></xsl:call-template>
</xsl:template>

<xsl:template name="menuRenderer">
  <xsl:param name="node" />
  <xsl:call-template name="menuChildNodeRenderer"><xsl:with-param name="parentNode" select="$node" /></xsl:call-template>
  <xsl:call-template name="menuContainer"><xsl:with-param name="node" select="$node" /></xsl:call-template>
</xsl:template>

<xsl:template name="menuChildNodeRenderer">
  <xsl:param name="parentNode" />
  <xsl:for-each select="$parentNode/*">
    <xsl:choose>
      <xsl:when test="local-name() = 'menu'"><xsl:call-template name="menuLink"><xsl:with-param name="node" select="." /></xsl:call-template></xsl:when>
      <xsl:when test="local-name() = 'link'"><xsl:call-template name="pageLink"><xsl:with-param name="node" select="." /></xsl:call-template></xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
    <xsl:if test="position() != last()"> | </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template name="menuLink">
  <xsl:param name="node" />
  <a href="javascript:void(0)" id="{$node/@id}-link" onmouseover="displaySubmenu(this)"><xsl:value-of select="$node/@label" /></a><xsl:text xml:space="preserve">&#x0A;&#x0D;</xsl:text>
</xsl:template>

<xsl:template name="pageLink">
  <xsl:param name="node" />
  <a href="/pages/{$node/@id}.xml" id="{$node/@id}-link" onmouseover="displaySubmenu(this)"><xsl:value-of select="$node/@label" /></a><xsl:text xml:space="preserve">&#x0A;&#x0D;</xsl:text>
</xsl:template>

<xsl:template name="menuContainer">
  <xsl:param name="node" />
  <xsl:for-each select="$node/menu:menu">
    <div id="{@id}-menu" style="display:none;"><xsl:text xml:space="preserve">&#x0A;&#x0D;</xsl:text>
      <xsl:call-template name="menuRenderer"><xsl:with-param name="node" select="." /></xsl:call-template>
    </div><xsl:text xml:space="preserve">&#x0A;&#x0D;</xsl:text>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
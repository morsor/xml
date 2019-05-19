<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" exclude-result-prefixes="page menu" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:page="http://sorensen.biz/page" xmlns:menu="http://sorensen.biz/menu">

<xsl:output method="xml" omit-xml-declaration="no" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" /> 

<!-- include general purpose templates -->
<xsl:include href="menu.xsl" />

<xsl:template match="/">
  <xsl:apply-templates />
</xsl:template>


<xsl:template match="page:page" xml:space="preserve">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>m o r t e n s . n e t</title>
<meta name="keywords" content="Morten, Sorensen, morsor" />
<meta name="description" content="It 's my net, and I'm not afraid to use it" />
<meta name="generator" content="morsor.dk SiteFramework 2.0" />
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta name="robots" content="all" />
<link rel="shortcut icon" href="/images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="/css/containers.css" />
<link rel="stylesheet" type="text/css" href="/css/elements.css" />
<link rel="stylesheet" type="text/css" href="/css/classes.css" />
<link rel="stylesheet" type="text/css" href="/css/quotes.css" />
<xsl:text disable-output-escaping="yes"><![CDATA[
<!--[if IE]>
<link rel="stylesheet" type="text/css" href="/css/ie.css" />
<![endif]-->
]]></xsl:text>
<script type="text/javascript" src="/js/ajax.js"></script>
<script type="text/javascript" src="/js/cookies.js"></script>
<script type="text/javascript" src="/js/quotes.js"></script>
<script type="text/javascript" src="/js/menu.js"></script>
<script type="text/javascript" src="/js/main.js"></script>
</head>

<body>

<div id="headerContainer">

  <div id="banner">m o r t e n s . n e t</div>

</div>

<div id="menuContainer">
  <xsl:apply-templates select="document('../xml/menu.xml')" />
</div>


<xsl:apply-templates />

<div id="footerContainer">
  <div id="footer">
    &#169; morten sorensen 2000 - 2006
  </div>
</div>

</body>
</html>
</xsl:template>


<xsl:template match="page:infobox">
  <div class="infobox">
  <xsl:apply-templates />
  </div>
</xsl:template>


<xsl:template match="page:caption">
  <b><xsl:value-of select="." disable-output-escaping="yes" /></b><br />
  <br />
</xsl:template>


<xsl:template match="page:content">
  <!--xsl:copy-of select="." /-->
  <xsl:value-of select="." />
</xsl:template>


<xsl:template match="page:body">
  <div id="contentContainer">
  <xsl:if test="@align">
    <xsl:attribute name="style">text-align:<xsl:value-of select="@align" />;</xsl:attribute>
  </xsl:if>
  <xsl:apply-templates />
  </div>
</xsl:template>


<xsl:template match="page:image">
  <img src="{@url}" alt="" /><br />
</xsl:template>


<xsl:template match="page:application">
  <xsl:choose>
    <xsl:when test="@id = 'randomQuoteDisplayer'"><xsl:call-template name="randomQuoteDisplayer" /></xsl:when>
  </xsl:choose>
</xsl:template>


<xsl:template name="randomQuoteDisplayer">
  <div id="quote">
    <a href="javascript:void(0)" onclick="viewPreviousQuote()">&lt;--</a> &#160; 
    <a href="javascript:void(0)" onclick="viewRandomQuote()">Random quote</a> &#160; 
    <a href="javascript:void(0)" onclick="viewNextQuote()">--&gt;</a> &#160; 
    <br />
    <br />
    "<span id="quoteContent">&#160;</span>"<br />
    <br />
    <span id="quoteOrigin">&#160;</span><br />
  </div>
</xsl:template>


<xsl:template name="nl2br">
   <xsl:param name="string" select="." />
   <xsl:variable name="from" select="'&#xA;'" />
   <xsl:variable name="to"><br />&#xA;</xsl:variable>
   <xsl:choose>
      <xsl:when test="contains($string, $from)">
         <xsl:value-of select="substring-before($string, $from)" />
         <xsl:copy-of select="$to" />
         <xsl:call-template name="stringReplace">
            <xsl:with-param name="string">
              <xsl:call-template name="trim">
                <xsl:with-param name="string" select="$string" />
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="from" select="$from" />
            <xsl:with-param name="to" select="$to" />
         </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$string" />
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>


<xsl:template name="stringReplace">
   <xsl:param name="string" />
   <xsl:param name="from" select="'&#xA;'" />
   <xsl:param name="to"><br />
   </xsl:param>
   <xsl:choose>
      <xsl:when test="contains($string, $from)">
         <xsl:value-of select="substring-before($string, $from)" />
         <xsl:copy-of select="$to" />
         <xsl:call-template name="stringReplace">
            <xsl:with-param name="string"
                            select="substring-after($string, $from)" />
            <xsl:with-param name="from" select="$from" />
            <xsl:with-param name="to" select="$to" />
         </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
         <xsl:value-of select="$string" />
      </xsl:otherwise>
   </xsl:choose>
</xsl:template>


<xsl:template name="mstrim">
  <xsl:param name="string"/>
  <xsl:value-of select="substring-before($string, ' ')"/>
</xsl:template>


<xsl:template name="trim">
  <xsl:param name="string"/>
  <xsl:call-template name="rightTrim">
    <xsl:with-param name="string" select="concat(substring(translate($string,' &#9;&#10;&#13;',''),1,1),substring-after($string,substring(translate($string,' &#9;&#10;&#13;',''),1,1)))"/>
    <!--xsl:with-param name="string"><xsl:call-template name="leftTrim"><xsl:with-param name="string" select="$string" /></xsl:call-template></xsl:with-param-->
  </xsl:call-template>
</xsl:template>


<xsl:template name="leftTrim">
  <xsl:param name="string"/>
  <xsl:value-of select="concat(substring(translate($string,' &#9;&#10;&#13;',''),1,1),substring-after($string,substring(translate($string,' &#9;&#10;&#13;',''),1,1)))"/>
</xsl:template>


<xsl:template name="rightTrim">
  <xsl:param name="string"/>
  <xsl:param name="i" select="string-length($string)"/>
  <xsl:choose>
    <xsl:when test="translate(substring($string,$i,1),' &#9;&#10;&#13;','')">
      <xsl:value-of select="substring($string,1,$i)"/>
    </xsl:when>
    <xsl:when test="$i&lt;2"/>
    <xsl:otherwise>
      <xsl:call-template name="rightTrim">
        <xsl:with-param name="string" select="$string"/>
        <xsl:with-param name="i" select="$i - 1"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


</xsl:stylesheet>
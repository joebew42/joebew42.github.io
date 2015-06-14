<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <head>
        <title>Joebew's events stream</title>
        <link href="http://fonts.googleapis.com/css?family=Fauna+One" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="events.css" />
      </head>
      <body>
        <h2>What's going on ...</h2>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="events">
    <ul>
      <xsl:apply-templates select="event"/>
    </ul>
  </xsl:template>

  <xsl:template match="event">
    <li class="event">
      <small><xsl:value-of select="@date"/></small>
      <br/>
      <xsl:apply-templates select="action"/>
      <xsl:apply-templates select="references"/>
    </li>
  </xsl:template>

  <xsl:template match="action">
    <span class="event-title"><xsl:value-of select="@type"/>&#160;<xsl:value-of select="."/></span>
  </xsl:template>

  <xsl:template match="references">
    <ul>
      <xsl:apply-templates select="reference"/>
    </ul>
  </xsl:template>

  <xsl:template match="reference">
    <li>
      <a target="_blank">
        <xsl:attribute name="href">
          <xsl:value-of select="@src"/>
        </xsl:attribute>
        <xsl:value-of select="@type"/>
      </a>
    </li>
  </xsl:template>

</xsl:stylesheet>

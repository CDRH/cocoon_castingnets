<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
                xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
                xmlns="http://www.w3.org/1999/XSL/Format"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="a rng tei teix"
                version="2.0">
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>
    TEI stylesheet
    dealing  with elements from the
      linking module, making XSL-FO output.
      </p>
         <p>
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

   
   
      </p>
         <p>Author: See AUTHORS</p>
         <p>Id: $Id: linking.xsl 8551 2011-02-12 13:58:27Z rahtz $</p>
         <p>Copyright: 2011, TEI Consortium</p>
      </desc>
   </doc>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>[fo] <param name="where">target of link</param>
      </desc>
   </doc>
  <xsl:template name="generateEndLink">
      <xsl:param name="where"/>
      <xsl:value-of select="$where"/>
  </xsl:template>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>[fo] <param name="ptr">whether the destination URL is also the body
    of the link</param>
         <param name="dest">destination URL</param>
      </desc>
   </doc>
  <xsl:template name="makeExternalLink">
      <xsl:param name="ptr"/>
      <xsl:param name="dest"/>
      <basic-link external-destination="url({$dest})">
         <xsl:choose>
            <xsl:when test="$ptr='true'">
               <xsl:call-template name="showXrefURL">
                  <xsl:with-param name="dest">
                     <xsl:value-of select="$dest"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates/>
            </xsl:otherwise>
         </xsl:choose>
      </basic-link>
  </xsl:template>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>[fo] <param name="ptr">ptr</param>
         <param name="target">target</param>
         <param name="dest">destination</param>
         <param name="body">body</param>
      </desc>
   </doc>
  <xsl:template name="makeInternalLink">
      <xsl:param name="ptr"/>
      <xsl:param name="class"/>
      <xsl:param name="target"/>
      <xsl:param name="dest"/>
      <xsl:param name="body"/>
      <xsl:variable name="W">
         <xsl:choose>
            <xsl:when test="$target">
               <xsl:value-of select="$target"/>
            </xsl:when>
            <xsl:when test="contains($dest,'#')">
               <xsl:value-of select="substring-after($dest,'#')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$dest"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <basic-link internal-destination="{$W}">
         <xsl:call-template name="linkStyle"/>
         <xsl:choose>
            <xsl:when test="not($body='')">
               <xsl:value-of select="$body"/>
            </xsl:when>
            <xsl:when test="$ptr='true'">
               <xsl:apply-templates mode="xref" select="key('IDS',$W)">
                  <xsl:with-param name="minimal" select="$minimalCrossRef"/>
               </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates/>
            </xsl:otherwise>
         </xsl:choose>
      </basic-link>
  </xsl:template>
</xsl:stylesheet>
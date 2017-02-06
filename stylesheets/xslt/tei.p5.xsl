<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0" >

  
  <xsl:output method="xhtml" indent="yes" encoding="UTF-8"/>
  <xsl:param name="pagetype">unset</xsl:param>
  <xsl:param name="subpagetype">unset</xsl:param>
  <xsl:param name="q">unset</xsl:param>
  <xsl:param name="pageid">unset</xsl:param>

  <xsl:include href="../../config/config.xsl"/>

  <xsl:include href="common.xsl"/>
  <xsl:include href="page_templates.xsl"/>
  <xsl:include href="html_template.xsl"/>
  
  
  <!--<xsl:include href="html/tei.xsl"/>-->
  
  <!-- Things to hide -->

  <xsl:template match="teiHeader | revisionDesc | publicationStmt | sourceDesc | fw | figDesc">
    <!-- hide --><xsl:text> </xsl:text>
  </xsl:template>

  <!-- Paragraphs and line breaks, add a rule check for nested paragraphs -->

  <xsl:template match="p">
    <xsl:choose>
      <xsl:when test="ancestor::*[name() = 'p']">
        <div class="p">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose> 
  </xsl:template>
  
  <xsl:template match="p[@rend='italics']">
    <p>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <em><xsl:apply-templates/></em>
    </p>
  </xsl:template>
  
  <xsl:template match="lb">
    <xsl:apply-templates/>
    <br/>
  </xsl:template>
  
  <!-- Links -->
  
  <xsl:template match="xref[@n]">
    <a href="{@n}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <!-- Elements to turn to DIV's -->
  
  <xsl:template match="text">
    <xsl:apply-templates/>
    
    <xsl:if test="//note[@place='foot']">
      <!-- <br/><h4>Footnotes</h4> -->
      <br /><hr />
    </xsl:if>
    <xsl:for-each select="//note[@place='foot']">
      <p>
        <xsl:value-of select="substring(@xml:id, 2)"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
        <a>
          <xsl:attribute name="href">
            <xsl:text>#</xsl:text>
            <xsl:text>body</xsl:text>
            <xsl:value-of select="@xml:id"/>

          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:text>foot</xsl:text>
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
          <xsl:text>[back]</xsl:text>
        </a>
      </p>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="byline | docDate | sp | speaker | letter | 
    notesStmt | titlePart | docDate | ab | trailer | 
    front | lg | l | bibl | dateline | salute | trailer | titlePage | closer">
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@type='handwritten'">
          <span>
            <xsl:attribute name="style">
              <xsl:text>font-style: italic;</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
      </xsl:choose>
    <xsl:text> </xsl:text>
    </div>
  </xsl:template>
  
  <!-- Special case, if encoding is fixed, can fold into rule above-->
  
  <xsl:template match="ab[@rend='italics']">
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <em><xsl:apply-templates/></em>
    </div>
  </xsl:template>

  <!-- Elements to turn to SPAN's -->

  <xsl:template match="docAuthor | orig | reg | persName | placeName ">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <xsl:text> </xsl:text>
    </span>
  </xsl:template>
  
  <!-- <xsl:template match="figure">
    <xsl:choose>
      <xsl:when test="@place">
        <span class="topicImage">
          <img>
            <xsl:attribute name="src">
              <xsl:value-of select="$siteroot"/>
              <xsl:text>imgs/</xsl:text>
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            </img>
        </span>
      </xsl:when>
      <xsl:when test="@facs">
        <span class="pageImage">
          <a>
            <xsl:attribute name="href">
              <xsl:text>figures/1000px/</xsl:text>
              <xsl:value-of select="@facs"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="class">
              <xsl:text>imglink</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="rel">
              <xsl:text>prettyPhoto[pp_gal]</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
              <xsl:text>&lt;a href="</xsl:text>
              <xsl:value-of select="$siteroot"/>
              <xsl:text>figures/1000px/</xsl:text>
              <xsl:value-of select="@facs"/>
              <xsl:text>" target="_blank" &gt;open image in new window&lt;/a&gt;</xsl:text>
            </xsl:attribute>
            <img src="figures/100px/{@facs}"/>
          </a>
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <span>
          <xsl:attribute name="class">
            <xsl:value-of select="name()"/>
          </xsl:attribute>
          <xsl:apply-templates/>
          <xsl:text> </xsl:text>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template> -->

  <!-- HEADS -->

  <xsl:template match="head">
    <xsl:choose>
      <xsl:when test="ancestor::*[name() = 'p']">
        <span class="head">
          <xsl:apply-templates/>
          </span>
      </xsl:when>
      <xsl:when test="ancestor::*[name() = 'figure']">
        <span class="head">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:when test=".[@type='sub']">
        <h3>
          <xsl:apply-templates/>
        </h3>
      </xsl:when>
      <xsl:when test="preceding::*[name() = 'head']">
        <h4>
          <xsl:apply-templates/>
        </h4>
      </xsl:when>
      <!-- <xsl:otherwise>
        <h2>
          <xsl:apply-templates/>
        </h2>
        </xsl:otherwise> -->
      <xsl:otherwise>
        <h4>
          <xsl:apply-templates/>
        </h4>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="div1[@type='html']">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <!-- Gaps, Additions, Deletes -->
  
  <xsl:template match="damage">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@type"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <xsl:text>[?]</xsl:text>
    </span>
  </xsl:template>
  
  <xsl:template match="gap">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@reason"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <xsl:text>[?]</xsl:text>
    </span>
  </xsl:template>
  
  <xsl:template match="del">
    <xsl:choose>
      <xsl:when test="@type='overwrite'">
        <!-- Don't show overwritten text -->
      </xsl:when>
      <xsl:otherwise>
        <del>
          <xsl:attribute name="class">
            <xsl:value-of select="@reason"/>
            <!--<xsl:apply-templates/>-->
            </xsl:attribute>
            <xsl:text>[?]</xsl:text>
        </del>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="add">
    <xsl:choose>
      <xsl:when test="@place='superlinear' or @place='supralinear'">
        <sup>
          <xsl:apply-templates/>
        </sup>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    
    
  </xsl:template>

<!-- Sic's and corrections -->
  
  <xsl:template match="choice[child::corr]">
    <a>
      <xsl:attribute name="rel">
        <xsl:text>tooltip</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>sic</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:apply-templates select="corr"/>​
      </xsl:attribute><xsl:apply-templates select="sic"/></a>​
  </xsl:template>


  <!-- Page Images -->

  <xsl:template match="pb">    
        <span class="pageImage">
          <a>
            <xsl:attribute name="href">
              <xsl:text>figures/1000px/</xsl:text>
              <xsl:value-of select="@facs"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="rel">
              <xsl:text>prettyPhoto[pp_gal]</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
              <xsl:text>&lt;a href="</xsl:text>
              <xsl:value-of select="$siteroot"/>
              <xsl:text>figures/1000px/</xsl:text>
              <xsl:value-of select="@facs"/>
              <xsl:text>" target="_blank" &gt;open image in new window&lt;/a&gt;</xsl:text>
            </xsl:attribute>
            <img src="figures/100px/{@facs}"/>
          </a>          
          <!--<br/>--><!--<xsl:value-of select="@facs"/>-->
        </span>      
  </xsl:template>
  
  <!-- Handwritten -->
  <xsl:template match="seg[@type='handwritten']">    
        <span>
          <xsl:attribute name="style">
            <xsl:text>font-style: italic;</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span>
  </xsl:template>
  

  <!-- Milestone / horizontal rule -->

  <xsl:template match="milestone">
    <div>
      <xsl:attribute name="class">
        <xsl:text>milestone </xsl:text>
        <xsl:value-of select="@unit"/>
      </xsl:attribute>
      <xsl:text> </xsl:text>
    </div>
  </xsl:template>

  <!-- Notes / Footnotes / references -->

  
  <xsl:template match="note">
    <xsl:choose>
      <xsl:when test="@place='foot'">
        <xsl:text> </xsl:text><a>
          <xsl:attribute name="href">
            <xsl:text>#</xsl:text>
            <xsl:text>foot</xsl:text>
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:text>body</xsl:text>
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
          
          <xsl:text>[note </xsl:text>
          <xsl:value-of select="substring(@xml:id, 2)"/>
          <xsl:text>]</xsl:text>
         </a>
      </xsl:when>
      <!--<xsl:when test="@xml:id">
        <p>
          <xsl:attribute name="id">
            <xsl:text>note</xsl:text>
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
          <xsl:apply-templates/>
          <a>
            <xsl:attribute name="href">
              <xsl:text>#ref</xsl:text>
              <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:attribute name="class">
              <xsl:text>inlinenote</xsl:text>
            </xsl:attribute>
            <xsl:text> [back]</xsl:text>
          </a>
        </p>
      </xsl:when>-->
      <xsl:when test="@type='editorial'"/>
        <!-- <div>
          <xsl:attribute name="class">
            <xsl:value-of select="@type"/>
            </xsl:attribute>
          <xsl:text>[</xsl:text>
        <xsl:value-of select="@type"></xsl:value-of>
        <xsl:text> note - </xsl:text>
          <xsl:apply-templates/>
          <xsl:text>]</xsl:text>
            </div> -->
      <!--<xsl:when test="@type='credit'">
        <div>
          <xsl:attribute name="class">
            <xsl:value-of select="@type"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </div>
      </xsl:when>-->
      <!--<xsl:when test="@n">
        <a>
          <xsl:attribute name="rel">
            <xsl:text>tooltip</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>footnote</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:apply-templates/>
          </xsl:attribute>
          <xsl:text> [note] </xsl:text>
        </a>​
      </xsl:when>-->
      <!--<xsl:when test="@type='authorial'">
        <br/><span>
          <xsl:attribute name="class">
            <xsl:value-of select="@type"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span><br/>
      </xsl:when>-->
      <!--<xsl:when test="@type='author'">
        <span>
          <xsl:attribute name="class">
            <xsl:value-of select="@type"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span>
      </xsl:when>-->
      <!--<xsl:when test="@type='archival'">
        <span>
          <xsl:attribute name="class">
            <xsl:value-of select="@type"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </span>
      </xsl:when>-->
      <!--<xsl:when test="@place='end'">
        <span>
          <xsl:attribute name="class">
            <xsl:value-of select="name()"/>
          </xsl:attribute>
          [<xsl:apply-templates/>]
        </span>
      </xsl:when>-->
      <xsl:otherwise>
        <div>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
      </xsl:otherwise>
    </xsl:choose> 
  </xsl:template>
  

  
  
  
  <xsl:template match="ref">
    <xsl:choose>
      <xsl:when test="starts-with(@target, 'n')">
        <xsl:variable name="n" select="@target"/>
        <a>
          <xsl:attribute name="id">
            <xsl:text>ref</xsl:text>
            <xsl:value-of select="@target"></xsl:value-of>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>inlinenote</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="href">
            <xsl:text>#note</xsl:text>
            <xsl:value-of select="@target"/>
          </xsl:attribute>
          <xsl:text> [note </xsl:text>
          <xsl:apply-templates></xsl:apply-templates>
          <xsl:text>] </xsl:text>
        </a>
      </xsl:when>
      <xsl:when test="starts-with(@target, 'edi')">
        <a href="{$siteroot}topics/{substring-before(@target, 'xml')}html">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="ends-with(@target, '.xml')">
        <a href="{$siteroot}{substring-before(@target, 'xml')}html">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <!--<xsl:when test="ends-with(@facs, '.xml')">
        <a href="{$siteroot}{substring-before(@facs, 'xml')}html">
          <xsl:apply-templates/>
        </a>
      </xsl:when>-->
      <xsl:when test="@type='link'">
        <a href="{@target}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> </xsl:text>
        <a href="{@target}" id="{@target}.ref" class="footnote">
         
            <xsl:choose>
              <xsl:when test="descendant::text()">
                <xsl:apply-templates/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@n"/>
              </xsl:otherwise>
            </xsl:choose>
          
        </a>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <!-- Rules for em tag -->
  
  <xsl:template
    match="term | foreign | emph | title[not(@level='a')] | biblScope[@type='volume'] | 
    hi[@rend='italic'] | hi[@rend='italics']">
    <em>
      <xsl:apply-templates/>
    </em>
  </xsl:template>
  
  <xsl:template
    match="hi[@rend='underlined']">
    <u>
      <xsl:apply-templates/>
    </u>
  </xsl:template>
  
  <!-- Things that should be strong -->
  
  <xsl:template match="item/label">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>
  
  <xsl:template match="hi[@rend='bold']">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>

  <!-- Rules to account for hi tags other than em and strong-->

  <xsl:template match="hi[@rend='underline']">
    <u>
      <xsl:apply-templates/>
    </u>
  </xsl:template>

  <xsl:template match="hi[@rend='quoted']">
    <xsl:text>"</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>"</xsl:text>
  </xsl:template>

  <xsl:template match="hi[@rend='super']">
    <sup>
      <xsl:apply-templates/>
    </sup>
  </xsl:template>

  <xsl:template match="hi[@rend='subscript']">
    <sub>
      <xsl:apply-templates/>
    </sub>
  </xsl:template>

  <xsl:template match="hi[@rend='smallcaps'] | hi[@rend='roman']">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@rend"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="hi[@rend='right'] | hi[@rend='center']">
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select="@rend"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- Div types for styling -->

    
 <xsl:template match="div1 | div2">
    <xsl:if test="preceding-sibling::div1">
      <br />
      <br />
    </xsl:if>
    <xsl:if test="preceding-sibling::div2">
      <br />
    </xsl:if>
    <div>      
      <xsl:attribute name="class">
        <xsl:value-of select="@type"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@subtype='handwritten'">    
          <span>
            <xsl:attribute name="style">
              <xsl:text>font-style: italic;</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates />
        </xsl:otherwise>
      </xsl:choose>      
    </div>
  </xsl:template>
  
  
  <!-- Signed -->
  <xsl:template match="//signed">
    <br /><xsl:apply-templates />
  </xsl:template>
  
  <!-- Table Rules -->
  
  <xsl:template match="table">
    <table>
      <xsl:apply-templates/>
    </table>
  </xsl:template>
 
  <xsl:template match="row">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>
  
  <xsl:template match="cell">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  
  <!-- Lists -->
  
  <xsl:template match="list">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>
  
  <xsl:template match="item">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

</xsl:stylesheet>

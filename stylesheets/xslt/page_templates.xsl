<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    
    
    
    
    
    
    
    <xsl:template name="mainContent">
        
        <!-- =====================================================================================
            Main Page - List content
            ===================================================================================== -->
        
        <xsl:if test="$pagetype = 'main'">
            <xsl:apply-templates/>
        </xsl:if>
        
        <!-- =====================================================================================
            Document Views
            ===================================================================================== -->
        
        <xsl:if test="$pagetype = 'document'">
            <xsl:call-template name="metadata"/>
            <xsl:apply-templates/>
        </xsl:if>
        
        <!-- =====================================================================================
            Browse
            ===================================================================================== -->
        
        <xsl:if test="$pagetype = 'browse'">
        
        
            <xsl:apply-templates/>
            
            <ul class="browsetypes">
                <li>
                    <a>
                        <xsl:if test="$subpagetype = 'type' or $subpagetype = 'unset'">
                            <xsl:attribute name="class"><xsl:text>selected</xsl:text></xsl:attribute>
                        </xsl:if>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$siteroot"/>
                            <xsl:text>browse/type/index.html</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Type</xsl:text>
                    </a>
                </li>
                <li>
                    <a>
                        <xsl:if test="$subpagetype = 'date'">
                            <xsl:attribute name="class"><xsl:text>selected</xsl:text></xsl:attribute>
                        </xsl:if>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$siteroot"/>
                            <xsl:text>browse/date/index.html</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Date</xsl:text>
                    </a>
                </li>
                <li>
                    <a>
                        <xsl:if test="$subpagetype = 'source'">
                            <xsl:attribute name="class"><xsl:text>selected</xsl:text></xsl:attribute>
                        </xsl:if>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$siteroot"/>
                            <xsl:text>browse/source/index.html</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Source</xsl:text>
                    </a>
                </li>
                <!--<li>
                    <a>
                        <xsl:if test="$subpagetype = 'filename'">
                            <xsl:attribute name="class"><xsl:text>selected</xsl:text></xsl:attribute>
                        </xsl:if>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$siteroot"/>
                            <xsl:text>browse/filename/index.html</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Filename</xsl:text>
                    </a>
                    </li>-->
            
            </ul>
            
            
            
            
            <!-- === Filename, temp === -->
            
            <xsl:choose>
                <xsl:when test="$subpagetype = 'filename'">
                    
                    <p>This listing is temporary while building the site. It will be removed when site goes live.</p>
                    
                    <xsl:call-template name="pagelist"/>
                    
                    
                    
                </xsl:when>
                
            <!-- === Date === -->
                <xsl:when test="$subpagetype = 'date'">
                    
                    <xsl:for-each select="document(concat($searchroot, '&amp;q=*&amp;start=0&amp;rows=200&amp;fl=id,date,titleMain,type,year&amp;sort=date+asc'))"
                        xpath-default-namespace="">   
                        
                        <xsl:for-each-group select="/response/result/doc" group-by="str[@name='year']">
                            <xsl:sort select="lower-case(str[@name='year'])"/>
                            <xsl:variable name="groupkey"><xsl:value-of select="translate(current-grouping-key(),' ','')"/></xsl:variable>
                            <h3><a name="{$groupkey}"><xsl:text> </xsl:text></a><xsl:value-of select="current-grouping-key()"/><xsl:text> </xsl:text></h3>
                            <ul class="searchresults">
                                <xsl:for-each select="current-group()">
                                    <li>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="$siteroot"/>
                                                <xsl:if test="starts-with(str[@name='id'], 'edi')">topics/</xsl:if>
                                                <xsl:value-of select="str[@name='id']"/>
                                                <xsl:text>.html</xsl:text>
                                            </xsl:attribute>
                                            
                                            <xsl:call-template name="extractDate"><xsl:with-param name="date"
                                                select="str[@name='date']" /></xsl:call-template> - <xsl:value-of select="str[@name='titleMain']"/>
                                        </a>
                                        
                                        
                                    </li>
                                    
                                </xsl:for-each>
                            </ul>
                            
                        </xsl:for-each-group>

                    </xsl:for-each>
                    
                </xsl:when>
                
                <!-- === Publication === -->
       
                <xsl:when test="$subpagetype = 'source'">
                    
                    <!-- Comments to be removed later begin -->
                    
                    <!--<p>Note: These are sorted by publication and then by date. I could change the secondary sort to be by title instead. </p>-->
                    
                    <!-- Comments to be removed later end -->
                    
                    <xsl:for-each select="document(concat($searchroot, '&amp;q=*&amp;start=0&amp;rows=200&amp;fl=id, date, titleMain,type, source&amp;sort=date+asc'))"
                        xpath-default-namespace="">
                        
                        <ul class="browsesubgroup">
                        <xsl:for-each-group select="/response/result/doc" group-by="str[@name='source']">
                            <xsl:sort select="lower-case(str[@name='source'])"/>
                            <xsl:variable name="groupkey"><xsl:value-of select="translate(current-grouping-key(),' ','')"/></xsl:variable>
                            <li><a href="#{$groupkey}"><xsl:value-of select="concat(upper-case(substring(current-grouping-key(), 1, 1)), substring(current-grouping-key(), 2))"/></a><xsl:text> </xsl:text></li>
                        </xsl:for-each-group>
                            </ul>
                        
                        <xsl:for-each-group select="/response/result/doc" group-by="str[@name='source']">
                            <xsl:sort select="lower-case(str[@name='source'])"/>
                            <xsl:variable name="groupkey"><xsl:value-of select="translate(current-grouping-key(),' ','')"/></xsl:variable>
                            <h3><a name="{$groupkey}"><xsl:text> </xsl:text></a><xsl:value-of select="concat(upper-case(substring(current-grouping-key(), 1, 1)), substring(current-grouping-key(), 2))"/><xsl:text> </xsl:text></h3>
                            <ul class="searchresults">
                            <xsl:for-each select="current-group()">
                                <li>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="$siteroot"/>
                                        <xsl:if test="starts-with(str[@name='id'], 'edi')">topics/</xsl:if>
                                        <xsl:value-of select="str[@name='id']"/>
                                        <xsl:text>.html</xsl:text>
                                    </xsl:attribute>
                                    
                                    <xsl:value-of select="str[@name='titleMain']"/> <xsl:text> (</xsl:text> 
                                    <xsl:call-template name="extractDate"><xsl:with-param name="date"
                                        select="str[@name='date']" /></xsl:call-template> <xsl:text>)</xsl:text>
                                </a>
                                
                                
                                </li>
                                
                                </xsl:for-each>
                                </ul>
                            
                        </xsl:for-each-group>
                        
                    </xsl:for-each>
                    
                </xsl:when>
                
                <!-- === Type, using otherwise to make it the default === -->
                <xsl:otherwise>
                    
                    <!-- Comments to be removed later begin -->
                    
                   <!-- <p>Note: These are sorted by type and then by date, with both date and source included in parentheticals. </p>-->
                    
                    <!-- Comments to be removed later end -->
                    
                
                <xsl:for-each select="document(concat($searchroot, '&amp;q=*&amp;start=0&amp;rows=200&amp;fl=id, date, titleMain,type, source&amp;sort=date+asc'))"
                    xpath-default-namespace="">
                    
                   <ul class="browsesubgroup">
                        <xsl:for-each-group select="/response/result/doc" group-by="str[@name='type']">
                            <xsl:sort select="lower-case(str[@name='type'])"/>
                            <xsl:variable name="groupkey"><xsl:value-of select="translate(current-grouping-key(),' ','')"/></xsl:variable>
                            <li><a href="#{$groupkey}"><xsl:value-of select="current-grouping-key()"/></a><xsl:text> </xsl:text></li>
                        </xsl:for-each-group>
                    </ul>
                    
                    <xsl:for-each-group select="/response/result/doc" group-by="str[@name='type']">
                        <xsl:sort select="lower-case(str[@name='type'])"/>
                        <xsl:variable name="groupkey"><xsl:value-of select="translate(current-grouping-key(),' ','')"/></xsl:variable>
                        <h3><a name="{$groupkey}"><xsl:text> </xsl:text></a><xsl:value-of select="current-grouping-key()"/><xsl:text> </xsl:text></h3>
                        <ul class="searchresults">
                            <xsl:for-each select="current-group()">
                                <li>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$siteroot"/>
                                            <xsl:if test="starts-with(str[@name='id'], 'edi')">topics/</xsl:if>
                                            <xsl:value-of select="str[@name='id']"/>
                                            <xsl:text>.html</xsl:text>
                                        </xsl:attribute>
                                        
                                        <strong><xsl:value-of select="str[@name='titleMain']"/></strong><xsl:text>   (</xsl:text><xsl:call-template name="extractDate"><xsl:with-param name="date"
                                            select="str[@name='date']" /></xsl:call-template><xsl:text>,  </xsl:text><xsl:value-of select="str[@name='source']"/><xsl:text>)</xsl:text>
                                    </a>
                                    
                                </li>
                                
                            </xsl:for-each>
                        </ul>
                        
                    </xsl:for-each-group>
                    
                </xsl:for-each>
                </xsl:otherwise>
                
                
                
                
            </xsl:choose>
            
            
        </xsl:if>
        
        <!-- =====================================================================================
            About
            ===================================================================================== -->
        
        <xsl:if test="$pagetype = 'about'">
      
            <xsl:apply-templates/>
        </xsl:if>
        
        <!-- =====================================================================================
            Search
            ===================================================================================== -->
        
        <xsl:if test="$pagetype = 'search'">
           <!-- <xsl:apply-templates/>-->
            
            <form action="result.html" method="get" enctype="application/x-www-form-urlencoded">
                
                <h3>Search by keyword:</h3>
                
                <input id="basic-q" type="text" name="q" value="" class="textField"/>
                
                <p class="submit">
                    <input type="submit" value="Search Documents" class="submit"/>
                </p>
                
                <p>Tips: <br/> To exclude a word, preceed with "-" (i.e. water -andes)<br/> 
                    To search for a phrase, include in quotations
                    (i.e. "fresh water")</p>
            </form>
        </xsl:if><!-- /search -->
        
        
        <!-- =====================================================================================
            Search Resupts
            ===================================================================================== -->
        
        
        <xsl:if test="$pagetype = 'searchresults'">
            <xsl:apply-templates/>
            
            <xsl:variable name="doc"
                select="concat($searchroot, '&amp;start=0&amp;rows=200&amp;fl=id,date,titleMain&amp;q=','%28',encode-for-uri($q),'%29')" />
            
            <xsl:for-each select="document($doc)"
                xpath-default-namespace="">
                
                <p>Your search for: <xsl:value-of select="$q"/> returned <xsl:value-of select="/response/result/@numFound"/> result<xsl:if test="not(/response/result/@numFound = 1)">s</xsl:if></p>
                
                <ul>
                <xsl:for-each select="/response/result/doc">
                    <li><a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$siteroot"/>
                            <xsl:value-of select="str[@name='id']"/>
                            <xsl:text>.html</xsl:text>
                        </xsl:attribute>
                        
                        <xsl:value-of select="str[@name='titleMain']"/>
                    </a>
                    </li>
             
                </xsl:for-each>
                </ul>
            </xsl:for-each>
            </xsl:if>
        
        <!-- =====================================================================================
            Map
            ===================================================================================== -->
        
        <xsl:if test="$pagetype = 'map'">
  
            <xsl:apply-templates/>
        </xsl:if>
        
    </xsl:template>
    
    
    
    
    <xsl:template name="pagelist">
        <!-- This code is just for listing the pages, would be replaced with SOLR or similar in final verion. -->
        <ul class="searchresults">
            <xsl:variable name="collection_location">../../xml?=*.xml;on-error=warning</xsl:variable>
            <xsl:for-each
                select="collection($collection_location)">
                <xsl:sort select="/TEI/@xml:id"/>
                
                <xsl:for-each-group select="/TEI/@xml:id" group-by=".">
                    
                    <li>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="$siteroot"/>
                                <xsl:value-of select="current-grouping-key()"/>
                                <xsl:text>.html</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="current-grouping-key()"/>
                        </a>
                        
                    </li>
                </xsl:for-each-group>
                
            </xsl:for-each>
        </ul>
    </xsl:template>
    
    
    
    
    <!-- The metadata will be different for every project. Address in project meeting early on. -->
    
    <xsl:template name="metadata">
        <div id= "bibliography" class="bibliography">
            <h4>Metadata:</h4>
            
            <xsl:if test="string(/TEI/teiHeader/fileDesc/sourceDesc/bibl/title[1])">
                <p>
                    <strong><xsl:text>Title: </xsl:text></strong>
                    <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/bibl/title[1]"/>
                </p>
            </xsl:if>
            
            <xsl:if test="string(/TEI/teiHeader/fileDesc/sourceDesc/bibl/date)">
                <p>
                    <strong><xsl:text>Date: </xsl:text></strong>
                    <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/bibl/date"/>
                </p>
            </xsl:if>
            
            <p>
                <strong><xsl:text>ID: </xsl:text></strong>
                <xsl:value-of select="/TEI/@xml:id"/>
            </p>
            
            <p>
                <strong><xsl:text>TEI-encoded XML: </xsl:text></strong>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="/TEI/@xml:id"/>
                        <xsl:text>.xml</xsl:text>
                    </xsl:attribute> <xsl:value-of select="/TEI/@xml:id"/>
                    <xsl:text>.xml</xsl:text>
                </a>
            </p>
            
            
        </div>
    </xsl:template>
    
    
    
</xsl:stylesheet>

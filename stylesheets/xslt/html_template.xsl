<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    
    
    
    <xsl:template match="/">
        
        <html lang="en" class="no-js {$pagetype}">
            <head profile="http://dublincore.org/documents/dcq-html/">
                <meta charset="utf-8"/>
                
                <!-- www.phpied.com/conditional-comments-block-downloads/ -->
                <!--[if IE]><![endif]-->
                
                <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame Remove this if you use the .htaccess -->
                <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
                
                
                
                <title>Casting Digital Nets</title>
                
                <!-- Dublin Core Metadata - remove all non applicable elements. full list of terms here: http://dublincore.org/documents/dcmi-terms/ -->
                
                <meta name="DC.title" lang="en" content=""/>
                <!-- Title -->
                <meta name="DC.creator"
                    content="Center for Digital Resources in the Humanities at the University of Nebraska-Lincoln"/>
                <!-- Creators, seperated by commas -->
                <meta name="DC.date" content=""/>
                <!-- Date Created -->
                <meta name="DC.subject" content=""/>
                <!-- Subject Word -->
                <meta name="DC.identifier" scheme="DCTERMS.URI" content=""/>
                <!-- URI -->
                <meta name="DC.abstract" content=""/>
                <!-- Can be same as Description -->
                <meta name="DC.description" content=""/>
                <!-- Can be same as Abstract -->
                <meta name="DC.format" scheme="DCTERMS.IMT" content="text/html"/>
                <!-- Should not change -->
                <meta name="DC.type" scheme="DCTERMS.DCMIType" content="Webpage"/>
                <!-- If you want to force a zotero item, use that item, i.e.: journalArticle-->
                <meta name="DC.Rights" content="Creative Commons"/>
                <!-- license -->
                <meta name="DC.Source" content=""/>
                <!-- The Source of the resource -->
                
                <!-- End Dublin Core -->
                
                <meta name="description" content=""/>
                <meta name="author" content=""/>
                
                <!--  Mobile Viewport Fix
                    j.mp/mobileviewport & davidbcalhoun.com/2010/viewport-metatag 
                    device-width : Occupy full width of the screen in its current orientation
                    initial-scale = 1.0 retains dimensions instead of zooming out if page height > device height
                    maximum-scale = 1.0 retains dimensions instead of zooming in if page width < device width
                -->
                <meta name="viewport"
                    content="width=device-width; initial-scale=1.0; maximum-scale=1.0;"/>
                
                
                <!-- Place favicon.ico and apple-touch-icon.png in the root of your domain and delete these references -->
                <link rel="shortcut icon" href="/favicon.ico"/>
                <link rel="apple-touch-icon" href="/apple-touch-icon.png"/>
                
                <!-- CSS Reset -->
                <link rel="stylesheet" href="{$siteroot}stylesheets/css/reset.css"/>
                
                <!-- CSS : implied media="all" -->
                <link rel="stylesheet" href="{$siteroot}stylesheets/css/style.css"/>
                
                <!-- CSS : implied media="all" -->
                <link rel="stylesheet" href="{$siteroot}stylesheets/css/print.css"/>
                
                <!-- JQuery, served from Google -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"> &#160; </script>
                
                <!-- JS including Pretty Photo Image Viewer -->
                <!--<link rel="stylesheet" href="{$siteroot}js/prettyPhoto_compressed_3.1.3/css/prettyPhoto.css"
                    type="text/css" media="screen" charset="utf-8"/>
                <script src="{$siteroot}js/prettyPhoto_compressed_3.1.3/js/jquery.prettyPhoto.js"> &#160; </script>
                <script src="{$siteroot}js/script.js"> &#160; </script>-->
                
                
                <!-- JS for shadowbox image viewer -->
                <link rel="stylesheet" href="{$siteroot}js/shadowbox-3.0.3/shadowbox.css" type="text/css" media="screen" charset="utf-8"/>
                <script src="{$siteroot}js/shadowbox-3.0.3/shadowbox.js"> &#160; </script>
                <script src="{$siteroot}js/script.js"> &#160; </script>
                
            </head>
            
            
            <body>
                
                <div id="header" class="header">
                    <div class="title"><h1><a href="{$siteroot}">Casting Digital Nets</a></h1>
                        <h2>Native dispossession, wildlife management, and federalism</h2></div>
                    <ul class="navigation">
                        <li><a class="main" href="{$siteroot}">Home</a></li>
                        <li><a class="map" href="{$siteroot}map/index.html">Map</a></li>
                        <li><a class="browse" href="{$siteroot}browse/index.html">Browse</a></li>
                        <li><a class="search" href="{$siteroot}search/index.html">Search</a></li>
                        <li><a class="about" href="{$siteroot}about/index.html">About</a></li>
                    </ul>
                </div><!-- /header -->
                
                
                
                <div id="section" class="section">
                    <xsl:call-template name="mainContent"/>
                </div><!-- /main -->
                
                
                
                <div id="footer" class="footer">
                    <p>Published by the <a href="http://cdrh.unl.edu">Center for Digital Research in the
                        Humanities</a>. 
                        <br/>Funded by the <a href="http://www.unl.edu/plains/welcome">Center for Great Plains Studies</a> and the <a href="http://www.unl.edu/plains/pha/pha.shtml">Plains Humanities Alliance</a> at the <a href="http://www.unl.edu">University of Nebraska-Lincoln</a>.</p>
                    <img src="{$siteroot}imgs/unl_black.png"
                        width="150" class="right"/>
                </div><!-- /footer -->    
                
                
            </body>
            
            
        </html>
        
        
    </xsl:template>
    
</xsl:stylesheet>

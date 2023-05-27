<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:METS="http://www.loc.gov/METS/"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <payload>
            <pid><xsl:value-of select="/METS:mets/@OBJID"/></pid>
            <xsl:apply-templates select="//METS:structMap/METS:div"/>
        </payload>
    </xsl:template>
    
    <xsl:template match="METS:div[@TYPE='FITS_Files']"/>
    <xsl:template match="METS:div[@TYPE='ACCESS']"/>
    
    <xsl:template match="METS:div">
        <xsl:param name="type" select="@TYPE"/>
        <xsl:element name="{$type}">
            <xsl:if test="@LABEL">
                <label><xsl:value-of select="@LABEL"/></label>
            </xsl:if>
            <xsl:if test="@ORDER">
                <order><xsl:value-of select="@ORDER"/></order>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="METS:fptr"> 
        <xsl:param name="fptr"><xsl:value-of select="@FILEID"/></xsl:param>
        <xsl:param name="contentid"><xsl:value-of select="concat('#', $fptr)"/></xsl:param>
        <url><xsl:value-of select="//METS:file[@ID=$fptr]/METS:FLocat/@xlink:href"/></url>
        <xsl:if test="//METS:div[@TYPE='FITS_Files']/METS:fptr[@CONTENTIDS=$contentid]/(@FILEID)">
            <xsl:variable name="fits"><xsl:value-of select="//METS:div[@TYPE='FITS_Files']/METS:fptr[@CONTENTIDS=$contentid]/@FILEID"/></xsl:variable>
            <fits><xsl:value-of select="//METS:file[@ID=$fits]/METS:FLocat/@xlink:href"/></fits>
        </xsl:if>
        <xsl:if test="//METS:file[@ID=$fptr]/@MIMETYPE">
             <mimetype><xsl:value-of select="//METS:file[@ID=$fptr]/@MIMETYPE"/></mimetype>
        </xsl:if>
        <xsl:if test="@xml:lang">
            <lang><xsl:value-of select="@xml:lang"/></lang>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>

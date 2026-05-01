<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <body>
                <ul>
                    <xsl:apply-templates select="items/item[@parentid='0']" />
                </ul>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="item">
        <li>
            <strong><xsl:value-of select="@author"/></strong>: 
            <xsl:value-of select="."/>
            <xsl:variable name="currentId" select="@id" />
            <xsl:if test="../item[@parentid = $currentId]">
                <ul>
                    <xsl:apply-templates select="../item[@parentid = $currentId]" />
                </ul>
            </xsl:if>
        </li>
    </xsl:template>

</xsl:stylesheet>
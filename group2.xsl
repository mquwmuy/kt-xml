<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes"/>


    <xsl:key name="cityKey" match="item" use="@city"/>
    <xsl:key name="orgKey" match="item" use="concat(@city, '|', @org)"/>

    <xsl:template match="/orgs">
        <html>
            <head>
                <style>
                    body { font-family: Arial; }
                    ul { list-style-type: disc; }
                    .count { margin-left: 20px; margin-bottom: 10px; display: block; }
                </style>
            </head>
            <body>
                <h1>Города и компании</h1>
                <ul>
                    <xsl:for-each select="item[generate-id(.) = generate-id(key('cityKey', @city)[1])]">
                        <xsl:variable name="currentCity" select="@city"/>
                        <li>
                            <strong><xsl:value-of select="$currentCity"/></strong>
                        </li>
                        <span class="count">Всего товаров: <xsl:value-of select="count(key('cityKey', $currentCity))"/></span>
                        
                        <ul>
                            <xsl:for-each select="key('cityKey', $currentCity)[generate-id(.) = generate-id(key('orgKey', concat(@city, '|', @org))[1])]">
                                <xsl:variable name="currentOrg" select="@org"/>
                                <xsl:variable name="fullKey" select="concat($currentCity, '|', $currentOrg)"/>
                                
                                <li>
                                    <xsl:value-of select="$currentOrg"/>
                                </li>
                                <span class="count">Всего товаров: <xsl:value-of select="count(key('orgKey', $fullKey))"/></span>
                                
                                <ul>
                                    <xsl:for-each select="key('orgKey', $fullKey)">
                                        <li><xsl:value-of select="@title"/></li>
                                    </xsl:for-each>
                                </ul>
                            </xsl:for-each>
                        </ul>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>


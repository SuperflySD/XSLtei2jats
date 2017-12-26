<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:mml="http://www.w3.org/1998/Math/MathML"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="xlink xs mml tei"
                version="1.0">

    <xsl:template match="/">
        <article article-type="research-article">
            <xsl:apply-templates select="tei:TEI/tei:teiHeader"/>
            <xsl:apply-templates select="tei:TEI/tei:text/tei:body"/>
            <xsl:apply-templates select="tei:TEI/tei:text/tei:back"/>
        </article>
    </xsl:template>

    <xsl:template match="tei:teiHeader">
        <front>
            <journal-meta>
                <journal-title>
                    <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title"/>
                </journal-title>
            </journal-meta>
            <article-meta>
                <title-group>
                    <article-title>
                        <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:title"/>
                    </article-title>
                </title-group>

                <!--Replace with appropriate JATS tag!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
                <xsl:for-each select="tei:fileDesc">
                    <xsl:for-each select="tei:publicationStmt">
                        <REPLACE-WITH-PUBLISHER>
                            <publisher>
                                <xsl:value-of select="tei:publisher"/>
                            </publisher>
                            <availability status="{tei:availability/attribute::status}">
                                <p>
                                    <xsl:value-of select="tei:availability"/>
                                </p>
                            </availability>
                            <date type="{tei:date/attribute::type}" when="{tei:date/attribute::when}">
                                <xsl:value-of select="tei:date"/>
                            </date>
                        </REPLACE-WITH-PUBLISHER>
                    </xsl:for-each>
                </xsl:for-each>

                <!--Replace with appropriate JATS tag!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
                <xsl:for-each select="tei:fileDesc/tei:sourceDesc/tei:biblStruct">
                    <xsl:for-each select="tei:monogr">
                        <REPLACE-WITH-monogr>
                            <xsl:for-each select="tei:title">
                                <title level="{attribute::level}" type="{attribute::type}">
                                    <xsl:value-of select="string(.)"/>
                                </title>
                            </xsl:for-each>
                            <xsl:for-each select="tei:indo">
                                <idno type="{attribute::type}">
                                    <xsl:value-of select="string(.)"/>
                                </idno>
                            </xsl:for-each>
                            <xsl:for-each select="tei:imprint">
                                <xsl:for-each select="tei:biblScope">
                                    <biblScope unit="{attribute::unit}" from="{attribute::from}" to="{attribute::to}">
                                        <xsl:value-of select="string(.)"/>
                                    </biblScope>
                                </xsl:for-each>
                            </xsl:for-each>
                        </REPLACE-WITH-monogr>
                    </xsl:for-each>
                    <xsl:for-each select="tei:idno">
                        <idno type="{attribute::type}">
                            <xsl:value-of select="string(.)"/>
                        </idno>
                    </xsl:for-each>
                    <xsl:for-each select="tei:note">
                        <note>
                            <xsl:value-of select="string(.)"/>
                        </note>
                    </xsl:for-each>
                </xsl:for-each>

                <!--Replace with keywords-->

                <xsl:for-each select="tei:profileDesc/tei:textClass/tei:keywords">
                    <keywords>
                        <xsl:for-each select="tei:term">
                            <term>
                                <xsl:value-of select="string(.)"/>
                            </term>
                        </xsl:for-each>
                    </keywords>
                </xsl:for-each>


                <contrib-group>
                    <xsl:for-each select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:author">
                        <contrib>
                            <name>
                                <surname>
                                    <xsl:value-of select="tei:persName/tei:surname"/>
                                </surname>
                                <given-names>
                                    <xsl:for-each select="tei:persName/tei:forename">
                                        <xsl:value-of select="string(.)"/>
                                    </xsl:for-each>
                                </given-names>
                            </name>
                            <aff>
                                <xsl:value-of select="tei:affiliation/tei:orgName[@type='institution']"/>
                                <named-content content-type="dept">
                                    <xsl:value-of select="tei:affiliation/tei:orgName[@type='department']"/>
                                </named-content>
                            </aff>
                        </contrib>
                    </xsl:for-each>
                </contrib-group>
                <abstract>
                    <xsl:apply-templates select="tei:profileDesc/tei:abstract"/>
                </abstract>
            </article-meta>
        </front>
    </xsl:template>

    <!--body-->

    <xsl:template match="tei:text/tei:body">
        <body>
            <xsl:for-each select="tei:div">
                <p>
                    <title>
                        <xsl:value-of select="tei:head"/>
                    </title>
                    <xsl:for-each select="tei:p">
                        <p>
                            <xsl:value-of select="string(self::node()/text()[1])"/>
                            <xsl:for-each select="tei:ref">
                                <xsl:variable name="index" select="position()"/>
                                <ref type="{attribute::type}">
                                    <xsl:value-of select="string(.)"/>
                                </ref>
                                <xsl:value-of select="string(parent::node()/text()[$index+1])"/>
                            </xsl:for-each>
                        </p>
                    </xsl:for-each>
                </p>
            </xsl:for-each>
            <xsl:for-each select="tei:figure">
                <figure>
                    <p>
                        <xsl:value-of select="tei:head"/>
                    </p>
                </figure>
            </xsl:for-each>
            <xsl:for-each select="tei:note">
                <note place="{attribute::place}" n="{attribute::n}">
                    <xsl:value-of select="string(.)"/>
                </note>
            </xsl:for-each>
        </body>
    </xsl:template>

    <!--back-->

    <xsl:template match="tei:text/tei:back">
        <back>
            <xsl:for-each select="tei:div">
                <xsl:for-each select="tei:div">
                    <p>
                        <title>
                            <xsl:value-of select="tei:head"/>
                        </title>
                        <xsl:for-each select="tei:p">
                            <p>
                                <xsl:value-of select="string(self::node()/text()[1])"/>
                                <xsl:for-each select="tei:ref">
                                    <xsl:variable name="index" select="position()"/>
                                    <ref type="{attribute::type}">
                                        <xsl:value-of select="string(.)"/>
                                    </ref>
                                    <xsl:value-of select="string(parent::node()/text()[$index+1])"/>
                                </xsl:for-each>
                            </p>
                        </xsl:for-each>
                    </p>
                </xsl:for-each>
            </xsl:for-each>
        </back>
    </xsl:template>


</xsl:stylesheet>
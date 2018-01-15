<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:mml="http://www.w3.org/1998/Math/MathML"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="xlink xs mml tei"
                version="1.0">

    <xsl:variable name="document-uri" select="document-uri(.)"/>
    <xsl:variable name="filename" select="(tokenize($document-uri,'/'))[last()]"/>
    <xsl:variable name="prefix" select="substring-before($filename, '.')"/>

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
                <xsl:if test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title">
                    <journal-title-group>
                        <journal-title>
                            <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title"/>
                        </journal-title>
                    </journal-title-group>
                </xsl:if>

                <!--ISSN-->
                <xsl:if test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:idno[@type='ISSN']">
                    <issn publication-format="print">
                        <xsl:value-of
                                select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:idno[@type='ISSN']"/>
                    </issn>
                </xsl:if>

                <xsl:if test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:idno[@type='eISSN']">
                    <issn publication-format="electronic">
                        <xsl:value-of
                                select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:idno[@type='eISSN']"/>
                    </issn>
                </xsl:if>

                <!--publisher-->
                <xsl:if test="tei:fileDesc/tei:publicationStmt">
                    <publisher>
                        <xsl:if test="tei:fileDesc/tei:publicationStmt/tei:publisher">
                            <publisher-name>
                                <xsl:value-of select="tei:fileDesc/tei:publicationStmt/tei:publisher"/>
                            </publisher-name>
                            <!--need to realise-->
                            <!--<publisher-loc>
                                <addr-line></addr-line>
                                <addr-line></addr-line>
                                <country></country>
                            </publisher-loc>-->

                        </xsl:if>
                    </publisher>
                </xsl:if>
            </journal-meta>
            <article-meta>
                <xsl:for-each select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:idno">
                    <article-id pub-id-type="{attribute::type}">
                        <xsl:value-of select="string(.)"/>
                    </article-id>
                </xsl:for-each>
                <title-group>
                    <article-title>
                        <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:title"/>
                    </article-title>
                </title-group>

                <contrib-group>
                    <xsl:for-each select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:author">

                        <xsl:choose>

                            <!--Corresp-->
                            <xsl:when test="@role='corresp'">
                                <corresp>
                                    Correspondence to:
                                    <xsl:for-each select="tei:persName/tei:forename">
                                        <xsl:value-of select="string(.)"/>&#160;
                                    </xsl:for-each>
                                    <xsl:value-of select="tei:persName/tei:surname"/>
                                    <xsl:if test="tei:persName/tei:roleName">
                                        <xsl:value-of select="tei:persName/tei:roleName"/>
                                    </xsl:if>

                                    <xsl:if test="tei:affiliation/tei:orgName[@type='department']|
                            tei:affiliation/tei:orgName[@type='institution']|tei:affiliation/tei:address">
                                            <xsl:for-each select="tei:affiliation/tei:orgName[@type='department']">
                                                <institution>
                                                    <xsl:value-of select="string(.)"/>
                                                </institution>
                                            </xsl:for-each>
                                            <xsl:for-each select="tei:affiliation/tei:orgName[@type='institution']">
                                                <institution>
                                                    <xsl:value-of select="string(.)"/>
                                                </institution>
                                            </xsl:for-each>
                                            <xsl:for-each select="tei:affiliation/tei:address">
                                                <xsl:if test="tei:postCode">
                                                    <postal-code>
                                                        <xsl:value-of select="tei:postCode"/>
                                                    </postal-code>
                                                </xsl:if>
                                                <xsl:if test="tei:postBox">
                                                    <addr-line>
                                                        <xsl:value-of select="tei:postBox"/>
                                                    </addr-line>
                                                </xsl:if>
                                                <xsl:if test="tei:addrLine">
                                                    <addr-line>
                                                        <xsl:value-of select="tei:addrLine"/>
                                                    </addr-line>
                                                </xsl:if>
                                                <xsl:if test="tei:settlement">
                                                    <city>
                                                        <xsl:value-of select="tei:settlement"/>
                                                    </city>
                                                </xsl:if>
                                                <xsl:if test="tei:country">
                                                    <country>
                                                        <xsl:copy-of select="tei:country/@*"/>
                                                        <xsl:value-of select="tei:country"/>
                                                    </country>
                                                </xsl:if>
                                                <xsl:if test="tei:region">
                                                    <state>
                                                        <xsl:copy-of select="tei:region/@*"/>
                                                        <xsl:value-of select="tei:region"/>
                                                    </state>
                                                </xsl:if>
                                            </xsl:for-each>
                                            <xsl:for-each select="tei:email">
                                                <email>
                                                    <xsl:value-of select="string(.)"/>
                                                </email>
                                            </xsl:for-each>
                                    </xsl:if>

                                </corresp>
                            </xsl:when>

                            <!--Author-->
                            <xsl:otherwise>
                                <contrib contrib-type="author">

                                    <string-name>
                                        <xsl:for-each select="tei:persName/tei:forename">
                                            <given-names>
                                                <xsl:value-of select="string(.)"/>
                                            </given-names>
                                        </xsl:for-each>
                                        <surname>
                                            <xsl:value-of select="tei:persName/tei:surname"/>
                                        </surname>

                                        <xsl:if test="tei:persName/tei:roleName">
                                            <role>
                                                <xsl:value-of select="tei:persName/tei:roleName"/>
                                            </role>
                                        </xsl:if>

                                    </string-name>

                                    <xsl:if test="tei:affiliation/tei:orgName[@type='department']|
                            tei:affiliation/tei:orgName[@type='institution']|tei:affiliation/tei:address">
                                        <aff rid="{tei:affiliation/attribute::key}">
                                            <xsl:for-each select="tei:affiliation/tei:orgName[@type='department']">
                                                <department>
                                                    <xsl:value-of select="string(.)"/>
                                                </department>
                                            </xsl:for-each>
                                            <xsl:for-each select="tei:affiliation/tei:orgName[@type='institution']">
                                                <institution>
                                                    <xsl:value-of select="string(.)"/>
                                                </institution>
                                            </xsl:for-each>
                                            <xsl:for-each select="tei:affiliation/tei:address">
                                                <address>
                                                    <xsl:if test="tei:postCode">
                                                        <postal-code>
                                                            <xsl:value-of select="tei:postCode"/>
                                                        </postal-code>
                                                    </xsl:if>
                                                    <xsl:if test="tei:postBox">
                                                        <addr-line>
                                                            <xsl:value-of select="tei:postBox"/>
                                                        </addr-line>
                                                    </xsl:if>
                                                    <xsl:if test="tei:addrLine">
                                                        <addr-line>
                                                            <xsl:value-of select="tei:addrLine"/>
                                                        </addr-line>
                                                    </xsl:if>
                                                    <xsl:if test="tei:settlement">
                                                        <city>
                                                            <xsl:value-of select="tei:settlement"/>
                                                        </city>
                                                    </xsl:if>
                                                    <xsl:if test="tei:country">
                                                        <country>
                                                            <xsl:copy-of select="tei:country/@*"/>
                                                            <xsl:value-of select="tei:country"/>
                                                        </country>
                                                    </xsl:if>
                                                    <xsl:if test="tei:region">
                                                        <state>
                                                            <xsl:copy-of select="tei:region/@*"/>
                                                            <xsl:value-of select="tei:region"/>
                                                        </state>
                                                    </xsl:if>
                                                </address>
                                            </xsl:for-each>
                                            <xsl:for-each select="tei:email">
                                                <email>
                                                    <xsl:value-of select="string(.)"/>
                                                </email>
                                            </xsl:for-each>
                                        </aff>
                                    </xsl:if>
                                </contrib>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </contrib-group>

                <xsl:for-each select="tei:fileDesc/tei:publicationStmt/tei:date">
                    <pub-date>
                        <string-date>
                            <xsl:value-of select="string(.)"/>
                        </string-date>
                    </pub-date>
                </xsl:for-each>

                <xsl:for-each select="tei:fileDesc/tei:sourceDesc/tei:biblStruct">
                    <!--   <xsl:if test="tei:monogr/tei:imprint/tei:date/@when">
                           <date>
                               <xsl:value-of select="tei:monogr/tei:imprint/tei:date/@when"/>
                           </date>
                       </xsl:if>-->
                    <xsl:if test="tei:monogr/tei:imprint/tei:biblScope[@unit='volume']">
                        <volume>
                            <xsl:value-of
                                    select="tei:monogr/tei:imprint/tei:biblScope[@unit='volume']"/>
                        </volume>
                    </xsl:if>
                    <xsl:if test="tei:monogr/tei:imprint/tei:biblScope[@unit='issue']">
                        <issue>
                            <xsl:value-of
                                    select="tei:monogr/tei:imprint/tei:biblScope[@unit='issue']"/>
                        </issue>
                    </xsl:if>
                    <xsl:if test="tei:monogr/tei:imprint/tei:biblScope[@unit='page']">
                        <xsl:choose>
                            <xsl:when
                                    test="tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@from | tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@to">
                                <fpage>
                                    <xsl:value-of
                                            select="tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@from"/>
                                </fpage>
                                <lpage>
                                    <xsl:value-of
                                            select="tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@to"/>
                                </lpage>
                            </xsl:when>

                            <xsl:otherwise>
                                <fpage>
                                    <xsl:value-of select="tei:monogr/tei:imprint/tei:biblScope[@unit='page']"/>
                                </fpage>
                                <lpage>
                                    <xsl:value-of select="tei:monogr/tei:imprint/tei:biblScope[@unit='page']"/>
                                </lpage>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>

                    <xsl:for-each select="tei:note">
                        <note>
                            <xsl:value-of select="string(.)"/>
                        </note>
                    </xsl:for-each>

                </xsl:for-each>

                <xsl:for-each select="tei:profileDesc/tei:textClass/tei:keywords">
                    <kwd-group kwd-group-type="author">
                        <title><bold>Keywords:</bold> 
                        </title>
                        <xsl:for-each select="tei:term">
                            <kwd>
                                <xsl:value-of select="string(.)"/>
                            </kwd>
                        </xsl:for-each>
                    </kwd-group>
                </xsl:for-each>

                <xsl:if test="tei:fileDesc/tei:publicationStmt/tei:availability/tei:p">
                    <permissions>
                        <copyright-statement>
                            <xsl:value-of select="tei:fileDesc/tei:publicationStmt/tei:availability/tei:p"/>
                        </copyright-statement>
                    </permissions>
                </xsl:if>

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
                <sec id="{concat('section',string(position()),'-',$prefix)}">
                    <title>
                        <xsl:value-of select="tei:head"/>
                    </title>
                    <xsl:for-each select="tei:p">
                        <p>
                            <xsl:value-of select="string(./text()[1])"/>
                            <xsl:for-each select="tei:ref">
                                <xsl:variable name="index" select="position()"/>

                                <ref>
                                    <xsl:copy-of select="@*"/>
                                    <xsl:value-of select="string(.)"/>
                                </ref>

                                <xsl:value-of select="string(../text()[$index+1])"/>
                            </xsl:for-each>
                        </p>
                    </xsl:for-each>
                </sec>
            </xsl:for-each>
            <xsl:for-each select="tei:figure">
                <figure>
                    <title>
                        <xsl:value-of select="tei:head"/>
                    </title>
                    <figDesc>
                        <xsl:value-of select="tei:figDesc"/>
                    </figDesc>

                </figure>
            </xsl:for-each>
            <xsl:for-each select="tei:note">
                <note>
                    <xsl:copy-of select="@*"/>
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
                    <title>
                        <xsl:value-of select="tei:head"/>
                    </title>
                    <xsl:for-each select="tei:p">
                        <p>
                            <xsl:value-of select="string(self::node()/text()[1])"/>
                            <xsl:for-each select="tei:ref">
                                <xsl:variable name="index" select="position()"/>
                                <ref>
                                    <xsl:copy-of select="@*"/>
                                    <xsl:value-of select="string(.)"/>
                                </ref>
                                <xsl:value-of select="string(parent::node()/text()[$index+1])"/>
                            </xsl:for-each>
                        </p>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>

            <!--references-->
            <xsl:if test="tei:div[@type='references']">

                <ref-list>
                    <title>References</title>

                    <xsl:for-each select="tei:div[@type='references']/tei:listBibl/tei:biblStruct">

                        <ref id="{attribute::xml:id}">
                            <xsl:choose>

                                <xsl:when test="not(tei:analytic/tei:title)">
                                    <mixed-citation publication-type="book">
                                        <xsl:apply-templates select="."/>
                                    </mixed-citation>
                                </xsl:when>

                                <xsl:otherwise>
                                    <mixed-citation publication-type="journal">
                                        <xsl:apply-templates select="."/>
                                    </mixed-citation>
                                </xsl:otherwise>
                            </xsl:choose>

                        </ref>
                    </xsl:for-each>
                </ref-list>
            </xsl:if>

        </back>
    </xsl:template>

    <!--Single book or article template-->
    <xsl:template match="tei:biblStruct">

        <!--Authors-->
        <xsl:if test="tei:analytic/tei:author | tei:monogr/tei:author">
            <person-group person-group-type="author">
                <xsl:for-each select="tei:analytic/tei:author | tei:monogr/tei:author">
                    <name>
                        <xsl:if test="tei:persName/tei:surname">
                            <surname>
                                <xsl:value-of select="tei:persName/tei:surname"/>
                            </surname>
                        </xsl:if>
                        <xsl:if test="tei:persName/tei:forename">
                            <given-names>
                                <xsl:for-each select="tei:persName/tei:forename">
                                    <xsl:value-of select="."/>&#160;
                                </xsl:for-each>
                            </given-names>
                        </xsl:if>
                    </name>
                </xsl:for-each>
            </person-group>
        </xsl:if>

        <!--Article title-->
        <xsl:if test="tei:analytic/tei:title">
            <article-title>
                <xsl:value-of select="tei:analytic/tei:title"/>
            </article-title>
        </xsl:if>

        <!--Journal title-->
        <xsl:if test="tei:monogr/tei:title">
            <source>
                <xsl:value-of select="tei:monogr/tei:title"/>
            </source>
        </xsl:if>

        <!--Date-->
        <xsl:if test="tei:monogr/tei:imprint/tei:date/@when">
            <date>
                <xsl:value-of select="tei:monogr/tei:imprint/tei:date/@when"/>
            </date>
        </xsl:if>

        <!--Publisher-->
        <xsl:if test="tei:monogr/tei:imprint/tei:publisher">
            <publisher-name>
                <xsl:value-of select="tei:monogr/tei:imprint/tei:publisher"/>
            </publisher-name>
        </xsl:if>
        <xsl:if test="tei:monogr/tei:imprint/tei:pubPlace">
            <publisher-loc>
                <xsl:value-of select="tei:monogr/tei:imprint/tei:pubPlace"/>
            </publisher-loc>
        </xsl:if>

        <!--Conference-->
        <xsl:if test="tei:monogr/tei:meeting">
            <conf-name>
                <xsl:value-of select="tei:monogr/tei:meeting/text()"/>
            </conf-name>
            <xsl:if test="tei:monogr/tei:meeting/tei:address">
                <conf-loc>
                    <xsl:value-of select="tei:monogr/tei:meeting/tei:address/tei:addrLine"/>
                </conf-loc>
            </xsl:if>
        </xsl:if>

        <!--Volume-->
        <xsl:if test="tei:monogr/tei:imprint/tei:biblScope[@unit='volume']">
            <volume>
                <xsl:value-of
                        select="tei:monogr/tei:imprint/tei:biblScope[@unit='volume']"/>
            </volume>
        </xsl:if>

        <!--Issue-->
        <xsl:if test="tei:monogr/tei:imprint/tei:biblScope[@unit='issue']">
            <issue>
                <xsl:value-of
                        select="tei:monogr/tei:imprint/tei:biblScope[@unit='issue']"/>
            </issue>
        </xsl:if>

        <!--Page-->
        <xsl:if test="tei:monogr/tei:imprint/tei:biblScope[@unit='page']">
            <xsl:choose>
                <xsl:when
                        test="tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@from | tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@to">
                    <fpage>
                        <xsl:value-of
                                select="tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@from"/>
                    </fpage>
                    <lpage>
                        <xsl:value-of
                                select="tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@to"/>
                    </lpage>
                </xsl:when>

                <xsl:otherwise>
                    <fpage>
                        <xsl:value-of select="tei:monogr/tei:imprint/tei:biblScope[@unit='page']"/>
                    </fpage>
                    <lpage>
                        <xsl:value-of select="tei:monogr/tei:imprint/tei:biblScope[@unit='page']"/>
                    </lpage>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

        <!--URL-->
        <xsl:if test="tei:monogr/tei:ptr[@target]">
            <uri>
                <xsl:value-of
                        select="tei:monogr/tei:ptr/@target"/>
            </uri>
        </xsl:if>
        <xsl:if test="tei:analytic/tei:ptr[@target]">
            <uri>
                <xsl:value-of
                        select="tei:analytic/tei:ptr/@target"/>
            </uri>
        </xsl:if>

        <!--ISSN-->
        <xsl:if test="tei:monogr/tei:idno[@type='ISSN']">
            <issn>
                <xsl:value-of select="tei:monogr/tei:idno[@type='ISSN']"/>
            </issn>
        </xsl:if>

        <!--DOI/ISSN-L-->
        <xsl:if test="tei:analytic/tei:idno[@type='doi']">
            <issn-l>
                <xsl:value-of select="tei:analytic/tei:idno[@type='doi']"/>
            </issn-l>
        </xsl:if>

        <!--Editor-->
        <xsl:if test="tei:monogr/tei:editor">
            <comment>
                Editors:
                <xsl:value-of select="tei:monogr/tei:editor"/>
            </comment>
        </xsl:if>

        <!--Organization/Institute-->
        <xsl:if test="tei:monogr/tei:respStmt/tei:orgName">
            <institution>
                <xsl:value-of select="tei:monogr/tei:respStmt/tei:orgName"/>
            </institution>
        </xsl:if>

        <!--Note-->
        <xsl:if test="tei:note">
            <comment>
                <xsl:value-of select="tei:note"/>
            </comment>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>
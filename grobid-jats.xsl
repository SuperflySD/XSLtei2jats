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
                <journal-title-group>
                    <journal-title>
                        <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title"/>
                    </journal-title>
                </journal-title-group>
                <!--need to realise-->
                <!--<issn ></issn>
                <issn ></issn>-->

                <!--publisher-->
                <xsl:for-each select="tei:fileDesc/tei:publicationStmt">
                    <xsl:for-each select="tei:publisher">
                        <publisher>
                            <publisher-name>
                                <xsl:value-of select="tei:publisher-name"/>
                            </publisher-name>
                            <!--need to realise-->
                            <!--<publisher-loc>
                                <addr-line></addr-line>
                                <addr-line></addr-line>
                                <country></country>
                            </publisher-loc>-->

                            <!--                     to be moved                                -->
                            <!--<availability>
                                <xsl:copy-of select="tei:availability/@*"/>
                                <xsl:value-of select="tei:availability"/>
                            </availability>-->
                        </publisher>
                        <!--                     to be moved                                -->
                        <!--  <xsl:for-each select="tei:date">
                              <date>
                                  <xsl:copy-of select="@*"/>
                                  <xsl:value-of select="tei:date"/>
                              </date>
                          </xsl:for-each>-->
                    </xsl:for-each>
                </xsl:for-each>
            </journal-meta>
            <article-meta>
                <!-- need to realise-->
                <!--  <article-id pub-id-type="publisher-id"></article-id>
                 <article-id pub-id-type="doi"></article-id>
                 <article-categories>
                     <subj-group subj-group-type="heading">
                         <subject></subject>
                     </subj-group>
                 </article-categories>-->

                <title-group>
                    <article-title>
                        <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:title"/>
                    </article-title>
                </title-group>

                <contrib-group>
                    <xsl:for-each select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:author">
                        <contrib contrib-type="author">
                            <string-name>
                                <surname>
                                    <xsl:value-of select="tei:persName/tei:surname"/>
                                </surname>
                                <given-names>
                                    <xsl:value-of select="tei:persName/tei:forename"/>
                                </given-names>
                            </string-name>
                            <aff rid="aff1">
                                <department>
                                    <xsl:value-of select="tei:affiliation/tei:orgName[@type='department']"/>
                                </department>
                                <institution>
                                    <xsl:value-of select="tei:affiliation/tei:orgName[@type='institution']"/>
                                </institution>
                                <xsl:for-each select="tei:affiliation/tei:address">
                                    <address>
                                        <postCode>
                                            <xsl:value-of select="tei:postCode"/>
                                        </postCode>
                                        <settlement>
                                            <xsl:value-of select="tei:settlement"/>
                                        </settlement>
                                        <country>
                                            <xsl:copy-of select="tei:country/@*"/>
                                            <xsl:value-of select="tei:country"/>
                                        </country>
                                    </address>
                                </xsl:for-each>
                            </aff>
                        </contrib>
                    </xsl:for-each>
                </contrib-group>

                <pub-date pub-type="pubDate">
                    <string-date>20171101</string-date>
                </pub-date>

                <!--Replace with appropriate JATS tag!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
                <xsl:for-each select="tei:fileDesc/tei:sourceDesc/tei:biblStruct">
                    <xsl:for-each select="tei:monogr">
                        <monogr>
                            <xsl:for-each select="tei:title">
                                <title>
                                    <xsl:copy-of select="@*"/>
                                    <xsl:value-of select="string(.)"/>
                                </title>
                            </xsl:for-each>
                            <xsl:for-each select="tei:indo">
                                <idno>
                                    <xsl:copy-of select="@*"/>
                                    <xsl:value-of select="string(.)"/>
                                </idno>
                            </xsl:for-each>
                            <xsl:for-each select="tei:imprint">
                                <xsl:for-each select="tei:biblScope">
                                    <biblScope>
                                        <xsl:copy-of select="@*"/>
                                        <xsl:value-of select="string(.)"/>
                                    </biblScope>
                                </xsl:for-each>
                            </xsl:for-each>
                        </monogr>
                    </xsl:for-each>

                    <xsl:for-each select="tei:idno">
                        <idno>
                            <xsl:copy-of select="@*"/>
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
                <sec>
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

                            <mixed-citation publication-type="journal">

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

                                <!--Conference-->
                                <xsl:if test="tei:monogr/tei:meeting">
                                    <conf-name>
                                        <xsl:value-of select="tei:monogr/tei:meeting"/>
                                    </conf-name>
                                    <xsl:if test="tei:monogr/tei:meeting/tei:address">
                                        <conf-loc>
                                            <xsl:value-of select="tei:monogr/tei:meeting/tei:address/tei:addrLine"/>
                                        </conf-loc>
                                    </xsl:if>
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

                                <!--Page from-->
                                <xsl:if test="tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@from">
                                    <fpage>
                                        <xsl:value-of
                                                select="tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@from"/>
                                    </fpage>
                                </xsl:if>

                                <!--Page to-->
                                <xsl:if test="tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@to">
                                    <lpage>
                                        <xsl:value-of
                                                select="tei:monogr/tei:imprint/tei:biblScope[@unit='page']/@to"/>
                                    </lpage>
                                </xsl:if>

                                <!--URL-->
                                <xsl:if test="tei:monogr/tei:ptr[@target]">
                                    <uri>
                                        <xsl:value-of
                                                select="tei:monogr/tei:ptr/@target"/>
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

                            </mixed-citation>
                        </ref>
                    </xsl:for-each>

                </ref-list>
            </xsl:if>

        </back>
    </xsl:template>

</xsl:stylesheet>
#!/bin/sh

if [ "$SAXON9_HOME" = "" ] ; then
  if [ -f saxon9he.jar ] ; then
    SAXON9=saxon9he.jar
  else
    echo Looks like you need to download Saxon.  Please see the README.md file.
    exit
  fi
else
  if [ -f $SAXON9_HOME/saxon9he.jar ] ; then
    SAXON9=$SAXON9_HOME/saxon9he.jar
  else
    if [ -f $SAXON9_HOME/saxon9.jar ] ; then
      SAXON9=$SAXON9_HOME/saxon9.jar
    else
      echo Can\'t find Saxon jar file.  Please see the README.md file.
      exit
    fi
  fi
fi

#HTML
 # java -jar $SAXON9 -xsl:jats2html.xsl -s:"126489119.pdf.tei.xml">HTML-126489119.html

#  java -jar $SAXON9 -xsl:grobid-jats.xsl -s:"123727552.pdf.tei.xml"> result-JATS.xml
#  java -jar $SAXON9 -xsl:grobid-jats.xsl -s:"p253-barberis.pdf.tei.xml"> JATS-p253-barberis.xml
  # java -jar $SAXON9 -xsl:grobid-jats.xsl -s:"125773301.pdf.tei.xml">JATS-125773301.xml
  # java -jar $SAXON9 -xsl:grobid-jats.xsl -s:"125996705.pdf.tei.xml">JATS-125996705.xml

  # java -jar $SAXON9 -xsl:grobid-jats.xsl -s:"126489113.pdf.tei.xml">JATS-126489113.xml
  # java -jar $SAXON9 -xsl:grobid-jats.xsl -s:"126489117.pdf.tei.xml">JATS-126489117.xml
 #  java -jar $SAXON9 -xsl:grobid-jats.xsl -s:"126489118.pdf.tei.xml">JATS-126489118.xml
  # java -jar $SAXON9 -xsl:grobid-jats.xsl -s:"126489119.pdf.tei.xml">JATS-126489119.xml


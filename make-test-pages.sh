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


  java -jar $SAXON9 -xsl:grobid-jats.xsl -s:"p253-barberis.pdf.tei.xml"> result-JATS.xml


<?xml version='1.0'?>

<!--********************************************************************
Copyright 2018 Robert A. Beezer

This file is part of PreTeXt.

PreTeXt is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 or version 3 of the
License (at your option).

PreTeXt is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with PreTeXt.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************-->

<!-- This is a modification of pretext-latex-chaos by Jesse Oldroyd. -->

<!-- Conveniences for classes of similar elements  -->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY % entities SYSTEM "entities.ent">
    %entities;
]>

<!-- Identify as a stylesheet -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
>

<!-- Override specific tenplates of the standard conversion -->
<xsl:import href="./core/pretext-latex.xsl"/>

<!-- Intend output for rendering by pdflatex -->
<xsl:output method="text" />

<!-- "abbr", "acro", "init" -->
<!-- Simply wild colors, for effect -->
<!-- Opposite of "red" (?) -->
<xsl:template match="abbr" mode="tex-macro-style">
    <xsl:text>\textcolor{-red}{#1}</xsl:text>
</xsl:template>
<!-- A "dvipsnames" color
<xsl:template match="acro" mode="tex-macro-style">
    <xsl:text>\textcolor{JungleGreen}{#1}</xsl:text>
</xsl:template> -->
<!-- A "svgnames" color -->
<xsl:template match="init" mode="tex-macro-style">
    <xsl:text>\textcolor{LightCoral}{#1}</xsl:text>
</xsl:template>

<!-- "commentary" -->
<!-- No options, so whatever is default tcolorbox -->
<xsl:template match="commentary" mode="tcb-style">
    <xsl:text/>
</xsl:template>

<!-- "objectives", "outcomes" -->
<!-- Green and ugly, plus identical, via the dual match -->
<xsl:template match="objectives|outcomes" mode="tcb-style">
    <xsl:text>size=minimal, attach title to upper, after title={\space}, fonttitle=\bfseries, coltitle=black, colback=green</xsl:text>
</xsl:template>

<!-- THEOREM-LIKE: "theorem", "corollary", "lemma",    -->
<!--               "algorithm", "proposition",         -->
<!--               "claim", "fact", "identity"         -->
<!-- AXIOM-LIKE: "axiom", "conjecture", "principle",   -->
<!--             "heuristic", "hypothesis",            -->
<!--             "assumption                           -->
<!-- A "skin" example from the tcolorbox documentation -->
<!-- Documentation suggests "title engine=path"        -->
<!-- is necessary, but it seems to not be              -->
<xsl:template match="&THEOREM-LIKE;|&AXIOM-LIKE;" mode="tcb-style">
    <xsl:text>enhanced, title engine=path, colback=red!8!white, &#xa;</xsl:text>
    <xsl:text>fonttitle=\sffamily &#xa;</xsl:text>
    <!-- <xsl:text>colframe=blue!75!black,coltitle=blue!10!white,fonttitle=\bfseries\sffamily,&#xa;</xsl:text> -->
    <!-- <xsl:text>colframe=red!75!black, coltitle=blue!50!black,fonttitle=\bfseries,&#xa;</xsl:text> -->
    <!-- <xsl:text>title style={left color=blue!15!black, right color=blue!45!black}, </xsl:text> -->
</xsl:template>

<!-- DEFINITION-LIKE: "definition"   -->
<!-- Various extreme choices from the tcolorbox documentation -->
<!-- Note: a trailing comma is OK, and maybe a good idea      -->
<!-- Note: the style definition may split across several line -->
<!-- of the LaTeX source using the hex A (dec 10) character   -->
<!-- Note: "enhanced" is necessary for boxed titles           -->
<xsl:template match="&DEFINITION-LIKE;" mode="tcb-style">
    <xsl:text>enhanced, arc=4mm,outer arc=1mm,colback=red!8,fonttitle=\sffamily,&#xa;</xsl:text>
    <!-- <xsl:text>attach boxed title to top center={yshift=-\tcboxedtitleheight/2},&#xa;</xsl:text> -->
    <xsl:text>boxed title style={size=small,colback=blue},&#xa;</xsl:text>
</xsl:template>

<!-- REMARK-LIKE: "remark", "convention", "note",   -->
<!--            "observation", "warning", "insight" -->
<!-- COMPUTATION-LIKE: "computation", "technology"  -->
 <!--White title text, but title backgounds vary    -->
 <!--by category, and remarks have sharp corners    -->
<xsl:template match="&REMARK-LIKE;" mode="tcb-style">
    <xsl:text>colbacktitle=red, sharp corners</xsl:text>
</xsl:template>
<xsl:template match="&COMPUTATION-LIKE;" mode="tcb-style">
    <xsl:text>colbacktitle=blue</xsl:text>
</xsl:template>

<!-- EXAMPLE-LIKE: "example", "question", "problem" -->
<!-- Default tcolorbox, but with tricolor titles    -->
<!-- Each just slightly different                   -->
<xsl:template match="example" mode="tcb-style">
    <xsl:text>colback=blue!8, fonttitle=\sffamily</xsl:text>
</xsl:template>
<xsl:template match="question" mode="tcb-style">
    <xsl:text>coltitle=blue</xsl:text>
</xsl:template>
<xsl:template match="problem" mode="tcb-style">
    <xsl:text>coltitle=yellow</xsl:text>
</xsl:template>

<!-- PROJECT-LIKE: "activity", "exploration",      -->
<!--               "exploration", "investigation"  -->
<!-- This from the tcolorbox documentation of      -->
<!-- the "tcbinvclipframe" documentation           -->
<xsl:template match="&PROJECT-LIKE;" mode="tcb-style">
    <xsl:text>enhanced jigsaw,fonttitle=\bfseries,opacityback=0.35,colback=blue!5!white,</xsl:text>
    <xsl:text>frame style={left color=red!75!black,right color=red!10!yellow},</xsl:text>
    <xsl:text>overlay={\begin{tcbinvclipframe}</xsl:text>
    <xsl:text>\draw[red,line width=1cm] ([xshift=-2mm,yshift=2mm]frame.north west)</xsl:text>
    <xsl:text>--([xshift=2mm,yshift=-2mm]frame.south east);</xsl:text>
    <xsl:text>\draw[red,line width=1cm] ([xshift=-2mm,yshift=-2mm]frame.south west)</xsl:text>
    <xsl:text>--([xshift=2mm,yshift=2mm]frame.north east);</xsl:text>
    <xsl:text>\end{tcbinvclipframe}}</xsl:text>
</xsl:template>

<!-- "assemblage" -->
<!-- Boxed title, borrowed from the AIM style -->
<xsl:template match="assemblage" mode="tcb-style">
    <xsl:text>enhanced, arc=2ex, colback=blue!5, colframe=blue!75!black,&#xa;</xsl:text>
    <xsl:text>colbacktitle=blue!20, coltitle=black, boxed title style={sharp corners, frame hidden},&#xa;</xsl:text>
    <xsl:text>fonttitle=\bfseries, attach boxed title to top left={xshift=4mm,yshift=-3mm}, top=3mm,&#xa;</xsl:text>
</xsl:template>

<!-- ASIDE-LIKE: "aside", "historical", "biographical" -->
<!-- Square, drop shadow, borrowed from the AIM style  -->
<xsl:template match="&ASIDE-LIKE;" mode="tcb-style">
    <xsl:text>enhanced, sharp corners, colback=blue!3, colframe=blue!50!black,&#xa;</xsl:text>
    <xsl:text>add to width=-1ex, shadow={1ex}{-1ex}{0ex}{black!50!white},&#xa;</xsl:text>
    <xsl:text>coltitle=black, fonttitle=\bfseries, attach title to upper, after title={\space},</xsl:text>
</xsl:template>

<!-- LaTeX uses four page styles, and we use the "titleps" package  -->
<!-- to redefine the "empty", "plain", and "headings" styles.  The  -->
<!-- actual management of which style is used, and when, is         -->
<!-- controlled by LaTeX with help from PreTeXt.  You can use the   -->
<!-- "titleps-global-style" template to change which style is the   -->
<!-- global default, optionally in concert with redefinitions of    -->
<!-- the style.                                                     -->
<!--                                                                -->
<!-- We do limited demonstration with the head, and use the         -->
<!-- left-side of the foot to display information on which          -->
<!-- pagestyle is in effect, so you could experiment here before    -->
<!-- making your own style.                                         -->
<!--                                                                -->
<!-- Note: the templates will be placed after a "\renewpagestyle{}" -->
<!-- command, so should be an optional argument, followed by a      -->
<!-- mandatory argument with commands like \setfoot, \sethead,      -->
<!-- \headrule, and \footrule.                                      -->
<!-- See titleps.pdf in the "titlesec" package for more             -->
<xsl:template match="book|article|letter|memo" mode="titleps-empty">
    <xsl:text>{
    \setfoot[][][]
    {}{}{}
    }</xsl:text>
</xsl:template>

<xsl:template match="book|article|letter|memo" mode="titleps-plain">
    <xsl:text>{
    \setfoot[][\thepage][]
    {}{\thepage}{}
    }</xsl:text>
</xsl:template>

<!-- This is cribbed from Section 8 of "titleps.pdf" (2016-03-15) -->
<!-- Adjusted Section/Chapter displays. -->
<xsl:template match="book" mode="titleps-headings">
    <xsl:text>[\small\sffamily]{
    \sethead[\textbf{\thepage}]
    [\textsl{\chaptertitle}]
    [Chapter~\thechapter]
    {Section~\thesection}
    {\textsl{\sectiontitle}}
    {\textbf{\thepage}}
    \setfoot[][\thepage][Section~\thesection]
    {Chapter~\thechapter}{\thepage}{}
    }</xsl:text>
</xsl:template>

<xsl:template match="article|letter|memo" mode="titleps-headings">
    <xsl:text>[\small\sffamily]{
    \headrule
    \sethead[\thepage][\sectiontitle][]
    {}{\sectiontitle}{\thepage}
    \setfoot[foot/odd/headings/article][][]
    {foot/even or one-sided/headings/article}{}{}
    }</xsl:text>
</xsl:template>

<!-- Experiment with "empty", "plain", and "headings" to      -->
<!-- see the effect of the above definitions (for "article")  -->
<!-- employed in the sample article                           -->
<!-- DO NOT set this to return empty text, errors will result -->
<!-- You can comment it out, and let base definition execute  -->
<xsl:template match="article" mode="titleps-global-style">
    <xsl:text>plain</xsl:text>
</xsl:template>

</xsl:stylesheet>
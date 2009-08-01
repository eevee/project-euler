<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="UTF-8" method="text" />

    <!-- iterate: Performs the actual iteration function -->
    <xsl:template name="iterate">
        <xsl:param name="value" select="1"/>
        <xsl:param name="running-count" select="1"/>

        <!-- If we haven't hit 1, we're not done yet!  Recurse. -->
        <xsl:if test="not($value = 1)">
            <xsl:variable name="next-value">
                <!-- If value is even, halve it -->
                <xsl:if test="$value mod 2 = 0">
                    <xsl:value-of select="$value div 2"/>
                </xsl:if>
                <!-- Otherwise, triple it and add 1 -->
                <xsl:if test="$value mod 2 = 1">
                    <xsl:value-of select="$value * 3 + 1"/>
                </xsl:if>
            </xsl:variable>

            <!-- Recurse -->
            <xsl:call-template name="iterate">
                <xsl:with-param name="value" select="$next-value"/>
                <xsl:with-param name="running-count" select="$running-count + 1"/>
            </xsl:call-template>
        </xsl:if>

        <!-- If we HAVE hit 1, print our result: the number of total steps -->
        <xsl:if test="$value = 1">
            <xsl:value-of select="$running-count"/>
        </xsl:if>
    </xsl:template>


    <!-- count-steps: Meat of this horrible mess. -->
    <!-- Runs our iterate() template for every value from n down to 1, and -->
    <!-- spits out the n that gives the longest chain -->
    <xsl:template name="count-steps" match="/">
        <xsl:param name="n" select="number(/maximum)"/>
        <xsl:param name="longest-chain-so-far" select="0"/>
        <xsl:param name="answer"/>

        <!-- MINOR OPTIMIZATION -->
        <!-- The correct optimization, of course, is to memoize every step -->
        <!-- of the iterator function.  Alas, XSLT cannot well do that. -->
        <!-- So the next best thing is to not call iterate() at all if we -->
        <!-- know our current $n is going to be a loser. -->
        <!-- If ($n - 1) mod 6 == 3, there is some odd $m such that -->
        <!-- $m * 3 + 1 == $n.  $m will beat $n by one, and we will test -->
        <!-- it later, so skip $n. -->
        <xsl:variable name="definite-loser" select="($n - 1) mod 6 = 3"/>

        <!-- Calculate the number of steps iterate() takes to stabilize -->
        <xsl:variable name="count">
            <!-- If $n can't win, just use 0 as a dummy result -->
            <xsl:if test="$definite-loser">
                0
            </xsl:if>
            <xsl:if test="not($definite-loser)">
                <xsl:call-template name="iterate">
                    <xsl:with-param name="value" select="$n"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:variable>

        <!-- LESS MINOR OPTIMIZATION -->
        <!-- If $n is greater than half the max, recurse all FP-like. -->
        <!-- When $n is less than half($maximum), there is no $n left for -->
        <!-- which we haven't tried $n * 2, and $n * 2 always beats $n. -->
        <xsl:if test="$n &gt;= number(/maximum) div 2">
            <!-- If this is still the longest chain, we wasted our time! -->
            <!-- Pass the current best chain length and answer along -->
            <xsl:if test="$longest-chain-so-far &gt; $count">
                <xsl:call-template name="count-steps">
                    <xsl:with-param name="n" select="$n - 1"/>
                    <xsl:with-param name="answer" select="$answer"/>
                    <xsl:with-param name="longest-chain-so-far" select="$longest-chain-so-far"/>
                </xsl:call-template>
            </xsl:if>

            <!-- Otherwise, use our new chain length and the corresponding n -->
            <xsl:if test="$longest-chain-so-far &lt;= $count">
                <xsl:call-template name="count-steps">
                    <xsl:with-param name="n" select="$n - 1"/>
                    <xsl:with-param name="answer" select="$n"/>
                    <xsl:with-param name="longest-chain-so-far" select="$count"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>

        <!-- Otherwise, we're done!  Print the result -->
        <xsl:if test="$n &lt; number(/maximum) div 2">
            <xsl:value-of select="$answer"/>
            <xsl:text>&#x0a;</xsl:text>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>

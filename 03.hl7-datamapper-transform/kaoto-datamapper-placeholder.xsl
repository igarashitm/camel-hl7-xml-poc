<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:hl7="urn:hl7-org:v2xml"
    exclude-result-prefixes="hl7">
  <xsl:output method="xml" indent="yes"/>

  <!-- Placeholder transformation - will be replaced by Kaoto DataMapper -->
  <!-- This transforms Hospital A format to Hospital B format -->

  <xsl:template match="/">
    <ADT_A01 xmlns="urn:hl7-org:v2xml">
      <!-- MSH Segment - Message Header -->
      <MSH>
        <MSH.1><xsl:value-of select="//hl7:MSH/hl7:MSH.1"/></MSH.1>
        <MSH.2><xsl:value-of select="//hl7:MSH/hl7:MSH.2"/></MSH.2>
        <!-- Transform: HOSP_A_ADT -> HOSP_B_ADT -->
        <MSH.3><HD.1>HOSP_B_ADT</HD.1></MSH.3>
        <!-- Transform: HOSPITAL_A -> HOSPITAL_B -->
        <MSH.4><HD.1>HOSPITAL_B</HD.1></MSH.4>
        <MSH.5><HD.1><xsl:value-of select="//hl7:MSH/hl7:MSH.5/hl7:HD.1"/></HD.1></MSH.5>
        <MSH.6><HD.1><xsl:value-of select="//hl7:MSH/hl7:MSH.6/hl7:HD.1"/></HD.1></MSH.6>
        <MSH.7><TS.1><xsl:value-of select="//hl7:MSH/hl7:MSH.7/hl7:TS.1"/></TS.1></MSH.7>
        <MSH.9>
          <MSG.1><xsl:value-of select="//hl7:MSH/hl7:MSH.9/hl7:MSG.1"/></MSG.1>
          <MSG.2><xsl:value-of select="//hl7:MSH/hl7:MSH.9/hl7:MSG.2"/></MSG.2>
        </MSH.9>
        <MSH.10><xsl:value-of select="//hl7:MSH/hl7:MSH.10"/></MSH.10>
        <MSH.11><PT.1><xsl:value-of select="//hl7:MSH/hl7:MSH.11/hl7:PT.1"/></PT.1></MSH.11>
        <MSH.12><VID.1><xsl:value-of select="//hl7:MSH/hl7:MSH.12/hl7:VID.1"/></VID.1></MSH.12>
      </MSH>

      <!-- EVN Segment - Event Type (unchanged) -->
      <EVN>
        <EVN.1><xsl:value-of select="//hl7:EVN/hl7:EVN.1"/></EVN.1>
        <EVN.2><TS.1><xsl:value-of select="//hl7:EVN/hl7:EVN.2/hl7:TS.1"/></TS.1></EVN.2>
      </EVN>

      <!-- PID Segment - Patient Identification -->
      <PID>
        <PID.1><xsl:value-of select="//hl7:PID/hl7:PID.1"/></PID.1>
        <!-- Transform: 12345^^^HOSP_A^MR -> HB-12345^^^HOSP_B^MR -->
        <PID.3>
          <CX.1><xsl:value-of select="concat('HB-', //hl7:PID/hl7:PID.3/hl7:CX.1)"/></CX.1>
          <CX.4><HD.1>HOSP_B</HD.1></CX.4>
          <CX.5><xsl:value-of select="//hl7:PID/hl7:PID.3/hl7:CX.5"/></CX.5>
        </PID.3>
        <!-- Patient Name (unchanged) -->
        <PID.5>
          <XPN.1><FN.1><xsl:value-of select="//hl7:PID/hl7:PID.5/hl7:XPN.1/hl7:FN.1"/></FN.1></XPN.1>
          <XPN.2><xsl:value-of select="//hl7:PID/hl7:PID.5/hl7:XPN.2"/></XPN.2>
          <XPN.3><xsl:value-of select="//hl7:PID/hl7:PID.5/hl7:XPN.3"/></XPN.3>
        </PID.5>
        <!-- Date of Birth (unchanged) -->
        <PID.7><TS.1><xsl:value-of select="//hl7:PID/hl7:PID.7/hl7:TS.1"/></TS.1></PID.7>
        <!-- Gender (unchanged) -->
        <PID.8><xsl:value-of select="//hl7:PID/hl7:PID.8"/></PID.8>
        <!-- Transform Address: MAIN ST -> Main Street, ANYTOWN -> Anytown -->
        <PID.11>
          <XAD.1><SAD.1><xsl:value-of select="replace(//hl7:PID/hl7:PID.11/hl7:XAD.1/hl7:SAD.1, 'MAIN ST', 'Main Street')"/></SAD.1></XAD.1>
          <XAD.3><xsl:value-of select="replace(//hl7:PID/hl7:PID.11/hl7:XAD.3, 'ANYTOWN', 'Anytown')"/></XAD.3>
          <XAD.4><xsl:value-of select="//hl7:PID/hl7:PID.11/hl7:XAD.4"/></XAD.4>
          <XAD.5><xsl:value-of select="//hl7:PID/hl7:PID.11/hl7:XAD.5"/></XAD.5>
          <XAD.6><xsl:value-of select="//hl7:PID/hl7:PID.11/hl7:XAD.6"/></XAD.6>
        </PID.11>
        <!-- Phone (unchanged) -->
        <PID.13><XTN.1><xsl:value-of select="//hl7:PID/hl7:PID.13/hl7:XTN.1"/></XTN.1></PID.13>
        <!-- Marital Status (unchanged) -->
        <PID.16><CE.1><xsl:value-of select="//hl7:PID/hl7:PID.16/hl7:CE.1"/></CE.1></PID.16>
        <!-- SSN (unchanged) - mapped from PID.18 -->
        <PID.19><xsl:value-of select="//hl7:PID/hl7:PID.18/hl7:CX.1"/></PID.19>
      </PID>

      <!-- PV1 Segment - Patient Visit -->
      <PV1>
        <PV1.1><xsl:value-of select="//hl7:PV1/hl7:PV1.1"/></PV1.1>
        <!-- Transform: I -> IP, O -> OP, E -> ER -->
        <PV1.2>
          <xsl:choose>
            <xsl:when test="//hl7:PV1/hl7:PV1.2 = 'I'">IP</xsl:when>
            <xsl:when test="//hl7:PV1/hl7:PV1.2 = 'O'">OP</xsl:when>
            <xsl:when test="//hl7:PV1/hl7:PV1.2 = 'E'">ER</xsl:when>
            <xsl:otherwise><xsl:value-of select="//hl7:PV1/hl7:PV1.2"/></xsl:otherwise>
          </xsl:choose>
        </PV1.2>
        <!-- Transform Location: WARD1^ROOM101^BED1^HOSP_A -> W1^R101^B1^HOSP_B -->
        <PV1.3>
          <PL.1><xsl:value-of select="replace(//hl7:PV1/hl7:PV1.3/hl7:PL.1, 'WARD1', 'W1')"/></PL.1>
          <PL.2><xsl:value-of select="replace(//hl7:PV1/hl7:PV1.3/hl7:PL.2, 'ROOM101', 'R101')"/></PL.2>
          <PL.3><xsl:value-of select="replace(//hl7:PV1/hl7:PV1.3/hl7:PL.3, 'BED1', 'B1')"/></PL.3>
          <PL.4><HD.1><xsl:value-of select="replace(//hl7:PV1/hl7:PV1.3/hl7:PL.4/hl7:HD.1, 'HOSP_A', 'HOSP_B')"/></HD.1></PL.4>
        </PV1.3>
        <!-- Transform Provider: add middle initial A -->
        <PV1.7>
          <XCN.1><xsl:value-of select="//hl7:PV1/hl7:PV1.7/hl7:XCN.1"/></XCN.1>
          <XCN.2><FN.1><xsl:value-of select="//hl7:PV1/hl7:PV1.7/hl7:XCN.2/hl7:FN.1"/></FN.1></XCN.2>
          <XCN.3>A</XCN.3>
          <XCN.5><xsl:value-of select="//hl7:PV1/hl7:PV1.7/hl7:XCN.5"/></XCN.5>
        </PV1.7>
        <!-- Service (unchanged) -->
        <PV1.10><xsl:value-of select="//hl7:PV1/hl7:PV1.10"/></PV1.10>
        <!-- Admission Type (unchanged) -->
        <PV1.14><xsl:value-of select="//hl7:PV1/hl7:PV1.14"/></PV1.14>
        <!-- Attending Doctor (same transformation as PV1.7) -->
        <PV1.17>
          <XCN.1><xsl:value-of select="//hl7:PV1/hl7:PV1.17/hl7:XCN.1"/></XCN.1>
          <XCN.2><FN.1><xsl:value-of select="//hl7:PV1/hl7:PV1.17/hl7:XCN.2/hl7:FN.1"/></FN.1></XCN.2>
          <XCN.3>A</XCN.3>
          <XCN.5><xsl:value-of select="//hl7:PV1/hl7:PV1.17/hl7:XCN.5"/></XCN.5>
        </PV1.17>
        <!-- Financial Class (unchanged) -->
        <PV1.18><xsl:value-of select="//hl7:PV1/hl7:PV1.18"/></PV1.18>
        <!-- Visit Number (unchanged) -->
        <PV1.19><CX.1><xsl:value-of select="//hl7:PV1/hl7:PV1.19/hl7:CX.1"/></CX.1></PV1.19>
        <!-- Admission Date/Time (unchanged) -->
        <PV1.44><TS.1><xsl:value-of select="//hl7:PV1/hl7:PV1.44/hl7:TS.1"/></TS.1></PV1.44>
      </PV1>
    </ADT_A01>
  </xsl:template>

</xsl:stylesheet>

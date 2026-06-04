# Route 2: HL7 XML to ER7 Conversion

This route demonstrates the reverse conversion: HL7 XML to ER7 format using standard marshal operation.

## Files

- **route-xml-to-er7.yaml** - Main route file
- **input/adt-a01-input.xml** - Sample HL7 XML message (can use output from Route 1)
- **output/** - Generated ER7 files

## Flow

```
File Consumer → Read HL7 XML → Marshal to ER7 → Log ER7 → Save to output/
```

## Prerequisites

- Camel JBang installed
- Java 17+
- Apache Camel 4.21.0-SNAPSHOT
- HL7 XML input file (use output from Route 1)

## Execution

```bash
cd 02.hl7-xml-to-er7
camel run route-xml-to-er7.camel.yaml --camel-version=4.21.0-SNAPSHOT
```

**Important Notes**:
- Input XML must be valid HAPI HL7 XML format (with `xmlns="urn:hl7-org:v2xml"`)
- The route will continuously process the input file until stopped (Ctrl+C)
- Output ER7 will use `\r` (carriage return) as segment separator

## Expected Output

The route will:
1. Read the HL7 XML message from `input/adt-a01-input.xml`
2. Unmarshal XML to HAPI Message object (automatic type conversion)
3. Marshal HAPI Message to ER7 format using standard `marshal.hl7`
4. Log the ER7 output to the console
5. Save the ER7 to `output/sample-adt-a01-er7.hl7`

The ER7 output will be pipe-delimited format with `\r` separators:
```
MSH|^~\&|SENDING_APP|SENDING_FACILITY|RECEIVING_APP|RECEIVING_FACILITY|20260603120000||ADT^A01|MSG00001|P|2.5
EVN|A01|20260603120000
PID|1||12345^^^HOSPITAL^MR||DOE^JOHN^M||19800101|M|||123 MAIN ST^^ANYTOWN^CA^12345^USA||(555)555-1234|||S||999-99-9999
PV1|1|I|WARD1^ROOM101^BED1^HOSPITAL||||DOCTOR123^SMITH^JANE|||MED||||1|||DOCTOR123^SMITH^JANE|INS|12345678|||||||||||||||||||||||||20260603120000
```

## Round-Trip Testing

Verify round-trip conversion:
1. Run Route 1 to convert ER7 → XML: `cd ../01.hl7-er7-to-xml && camel run route-er7-to-xml.yaml --camel-version=4.21.0-SNAPSHOT`
2. Copy XML output to Route 2 input: `cp ../01.hl7-er7-to-xml/output/sample-adt-a01-hapi.xml input/adt-a01-input.xml`
3. Run Route 2 to convert XML → ER7: `camel run route-xml-to-er7.yaml --camel-version=4.21.0-SNAPSHOT`
4. Compare outputs - they should be semantically equivalent

**Note**: The marshal operation does NOT use `targetFormat` parameter. It always produces ER7 format by default.

## Next Steps

See Route 3 (`03.hl7-datamapper-transform/`) for data transformation using Kaoto DataMapper with XSLT.

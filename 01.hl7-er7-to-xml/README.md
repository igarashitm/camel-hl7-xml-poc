# Route 1: HL7 ER7 to XML Conversion

This route demonstrates basic HL7 ER7 to XML conversion using the new `targetFormat=XML` feature from CAMEL-23669.

## Files

- **route-er7-to-xml.yaml** - Main route file
- **input/adt-a01-input.hl7** - Sample HL7 v2.5 ADT^A01 message (ER7 format with \r line endings)
- **output/** - Generated XML files

## Flow

```
File Consumer → Read HL7 ER7 → Unmarshal (targetFormat=XML) → Log XML → Save to output/
```

## Prerequisites

- Camel JBang installed
- Java 17+
- Apache Camel 4.21.0-SNAPSHOT with PR #23741 merged (fixes targetFormat in YAML DSL)

## Execution

```bash
cd 01.hl7-er7-to-xml
camel run route-er7-to-xml.camel.yaml --dep=mvn:ca.uhn.hapi:hapi-structures-v25:2.6.0
```

**Important Notes**:
- This route requires Camel 4.21.0-SNAPSHOT with PR #23741 merged
- HL7 files must use `\r` (carriage return) as segment separator, not `\n` (line feed)
- The route will continuously process the input file until stopped (Ctrl+C)

## Expected Output

The route will:
1. Read the HL7 ER7 message from `input/adt-a01-input.hl7`
2. Convert it to XML format using HAPI's XML parser via `targetFormat: XML`
3. Log the XML output to the console
4. Save the XML to `output/sample-adt-a01-hapi.xml`

The XML output follows the HAPI HL7 XML format with elements like:
- `<ADT_A01 xmlns="urn:hl7-org:v2xml">` - Root element with namespace
- `<MSH>` - Message header segment
- `<PID>` - Patient identification segment
- `<PV1>` - Patient visit segment

## Key Feature

The `targetFormat: XML` parameter in the unmarshal step is the key feature being demonstrated. This new capability (added in Camel 4.21.0 via CAMEL-23669) allows direct conversion from HL7 ER7 to XML format.

**Technical Details**:
- `unmarshal.hl7.targetFormat: XML` returns an `org.w3c.dom.Document` instead of a HAPI Message object
- The Document is automatically converted to String when writing to file
- No manual HAPI API calls needed

## Next Steps

See Route 2 (`02.hl7-xml-to-er7/`) for the reverse conversion (XML to ER7).

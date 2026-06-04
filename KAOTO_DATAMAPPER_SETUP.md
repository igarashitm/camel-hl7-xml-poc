# Kaoto DataMapper Setup Guide

This guide explains how to configure Kaoto DataMapper for the Route 3 Hospital A → Hospital B transformation.

## Schema Configuration

Both source and target use the same schema — this is an HL7→HL7 transformation (same message structure, different field values).

| Setting | Value |
|---------|-------|
| **Root element** | `ADT_A01` |
| **Namespace** | `urn:hl7-org:v2xml` |

### Schema files to attach

The HL7 v2.5 XML schemas have a dependency chain. Attach all four files in DataMapper:

```
ADT_A01.xsd      (message structure — includes segments.xsd)
  └─ segments.xsd  (segment definitions — includes fields.xsd)
      └─ fields.xsd  (field definitions — includes datatypes.xsd)
          └─ datatypes.xsd  (data type definitions — no further dependencies)
```

All files are in `03.hl7-datamapper-transform/schemas/`.

## Steps

1. Open `03.hl7-datamapper-transform/route-transform.yaml` in VSCode with the Kaoto extension
2. Click on the XSLT transformation step in the visual editor
3. Select "Configure DataMapper"
4. Set **source schema** to `schemas/ADT_A01.xsd`, root element `ADT_A01`
5. Set **target schema** to `schemas/ADT_A01.xsd`, root element `ADT_A01`
6. Create the mappings described below
7. Save — Kaoto generates the XSLT file that replaces the placeholder

## Mapping Table

The Hospital A → Hospital B transformation uses three types of mappings:

### Constant values (no source mapping)

| Target Field | Value |
|---|---|
| `/ADT_A01/MSH/MSH.3/HD.1` | `HOSP_B_ADT` |
| `/ADT_A01/MSH/MSH.4/HD.1` | `HOSPITAL_B` |
| `/ADT_A01/PID/PID.3/CX.4/HD.1` | `HOSP_B` |
| `/ADT_A01/PV1/PV1.7/XCN.3` | `A` (middle initial) |
| `/ADT_A01/PV1/PV1.17/XCN.3` | `A` (middle initial) |

### Transformations (source value-of with function)

| Source Field | Target Field | Expression |
|---|---|---|
| `/ADT_A01/PID/PID.3/CX.1` | `/ADT_A01/PID/PID.3/CX.1` | `concat('HB-', .)` |
| `/ADT_A01/PID/PID.11/XAD.1/SAD.1` | `/ADT_A01/PID/PID.11/XAD.1/SAD.1` | `replace(., 'MAIN ST', 'Main Street')` |
| `/ADT_A01/PID/PID.11/XAD.3` | `/ADT_A01/PID/PID.11/XAD.3` | `replace(., 'ANYTOWN', 'Anytown')` |
| `/ADT_A01/PV1/PV1.2` | `/ADT_A01/PV1/PV1.2` | `choose`: `I`→`IP`, `O`→`OP`, `E`→`ER` |
| `/ADT_A01/PV1/PV1.3/PL.1` | `/ADT_A01/PV1/PV1.3/PL.1` | `replace(., 'WARD1', 'W1')` |
| `/ADT_A01/PV1/PV1.3/PL.2` | `/ADT_A01/PV1/PV1.3/PL.2` | `replace(., 'ROOM101', 'R101')` |
| `/ADT_A01/PV1/PV1.3/PL.3` | `/ADT_A01/PV1/PV1.3/PL.3` | `replace(., 'BED1', 'B1')` |
| `/ADT_A01/PV1/PV1.3/PL.4/HD.1` | `/ADT_A01/PV1/PV1.3/PL.4/HD.1` | `replace(., 'HOSP_A', 'HOSP_B')` |

### Direct mappings (source value-of, unchanged)

All remaining fields are direct source → target copies:

- **MSH**: `/ADT_A01/MSH/MSH.1`, `/ADT_A01/MSH/MSH.2`, `/ADT_A01/MSH/MSH.5/HD.1`, `/ADT_A01/MSH/MSH.6/HD.1`, `/ADT_A01/MSH/MSH.7/TS.1`, `/ADT_A01/MSH/MSH.9/MSG.1`, `/ADT_A01/MSH/MSH.9/MSG.2`, `/ADT_A01/MSH/MSH.10`, `/ADT_A01/MSH/MSH.11/PT.1`, `/ADT_A01/MSH/MSH.12/VID.1`
- **EVN**: `/ADT_A01/EVN/EVN.1`, `/ADT_A01/EVN/EVN.2/TS.1`
- **PID**: `/ADT_A01/PID/PID.1`, `/ADT_A01/PID/PID.3/CX.5`, `/ADT_A01/PID/PID.5/XPN.1/FN.1`, `/ADT_A01/PID/PID.5/XPN.2`, `/ADT_A01/PID/PID.5/XPN.3`, `/ADT_A01/PID/PID.7/TS.1`, `/ADT_A01/PID/PID.8`, `/ADT_A01/PID/PID.11/XAD.4`, `/ADT_A01/PID/PID.11/XAD.5`, `/ADT_A01/PID/PID.11/XAD.6`, `/ADT_A01/PID/PID.13/XTN.1`, `/ADT_A01/PID/PID.16/CE.1`, `/ADT_A01/PID/PID.18/CX.1`
- **PV1**: `/ADT_A01/PV1/PV1.1`, `/ADT_A01/PV1/PV1.7/XCN.1`, `/ADT_A01/PV1/PV1.7/XCN.2/FN.1`, `/ADT_A01/PV1/PV1.7/XCN.5`, `/ADT_A01/PV1/PV1.10`, `/ADT_A01/PV1/PV1.14`, `/ADT_A01/PV1/PV1.17/XCN.1`, `/ADT_A01/PV1/PV1.17/XCN.2/FN.1`, `/ADT_A01/PV1/PV1.17/XCN.5`, `/ADT_A01/PV1/PV1.18`, `/ADT_A01/PV1/PV1.19/CX.1`, `/ADT_A01/PV1/PV1.44/TS.1`

## XPath Reference

Useful paths when working with the HL7 v2.5 XML structure in DataMapper:

```
/ADT_A01/MSH/MSH.3/HD.1          Sending Application
/ADT_A01/MSH/MSH.4/HD.1          Sending Facility
/ADT_A01/PID/PID.3/CX.1          Patient ID
/ADT_A01/PID/PID.3/CX.4/HD.1     Assigning Authority
/ADT_A01/PID/PID.5/XPN.1/FN.1    Patient Last Name
/ADT_A01/PID/PID.5/XPN.2         Patient First Name
/ADT_A01/PID/PID.11/XAD.1/SAD.1  Street Address
/ADT_A01/PID/PID.11/XAD.3        City
/ADT_A01/PV1/PV1.2               Patient Class (I/O/E)
/ADT_A01/PV1/PV1.3/PL.1          Ward
/ADT_A01/PV1/PV1.3/PL.2          Room
/ADT_A01/PV1/PV1.3/PL.3          Bed
/ADT_A01/PV1/PV1.3/PL.4/HD.1     Facility
/ADT_A01/PV1/PV1.7/XCN.2/FN.1    Attending Doctor Last Name
/ADT_A01/PV1/PV1.7/XCN.3         Attending Doctor First Name
```

## Troubleshooting

If DataMapper has trouble loading the schema:
- Verify all four schema files are attached: `ADT_A01.xsd`, `segments.xsd`, `fields.xsd`, `datatypes.xsd`
- Check that all schemas use namespace `urn:hl7-org:v2xml`
- Ensure all four files are in the same directory (`03.hl7-datamapper-transform/schemas/`)

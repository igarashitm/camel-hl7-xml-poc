# Kaoto DataMapper Setup Guide

This guide explains how to configure Kaoto DataMapper for the Route 3 Hospital A → Hospital B transformation.

## Schema Configuration

Both source and target use the same schema — this is an HL7→HL7 transformation (same message structure, different field values).

| Setting | Value |
|---------|-------|
| **Schema file** | `../schemas/ADT_A01.xsd` (relative to the route file) |
| **Root element** | `ADT_A01` |
| **Namespace** | `urn:hl7-org:v2xml` |

`ADT_A01.xsd` automatically includes all dependent schemas (`segments.xsd`, `fields.xsd`, `datatypes.xsd`). You do not need to load them separately.

## Steps

1. Open `03.hl7-datamapper-transform/route-transform.yaml` in VSCode with the Kaoto extension
2. Click on the XSLT transformation step in the visual editor
3. Select "Configure DataMapper"
4. Set **source schema** to `../schemas/ADT_A01.xsd`, root element `ADT_A01`
5. Set **target schema** to `../schemas/ADT_A01.xsd`, root element `ADT_A01`
6. Create the mappings described below
7. Save — Kaoto generates the XSLT file that replaces the placeholder

## Mapping Table

The Hospital A → Hospital B transformation requires these mappings:

| Source Field | Target Field | Transformation |
|---|---|---|
| `MSH/MSH.3` | `MSH/MSH.3` | Constant: `HOSP_B_ADT` |
| `MSH/MSH.4` | `MSH/MSH.4` | Constant: `HOSPITAL_B` |
| `PID/PID.3/CX.1` | `PID/PID.3/CX.1` | Concat `HB-` + source value |
| `PID/PID.3/CX.4/HD.1` | `PID/PID.3/CX.4/HD.1` | Constant: `HOSP_B` |
| `PID/PID.11/XAD.1/SAD.1` | `PID/PID.11/XAD.1/SAD.1` | Replace `MAIN ST` → `Main Street` |
| `PID/PID.11/XAD.3` | `PID/PID.11/XAD.3` | Replace `ANYTOWN` → `Anytown` |
| `PV1/PV1.2` | `PV1/PV1.2` | Map: `I`→`IP`, `O`→`OP`, `E`→`ER` |
| `PV1/PV1.3/PL.1` | `PV1/PV1.3/PL.1` | Replace `WARD1` → `W1` |
| `PV1/PV1.3/PL.2` | `PV1/PV1.3/PL.2` | Replace `ROOM101` → `R101` |
| `PV1/PV1.3/PL.3` | `PV1/PV1.3/PL.3` | Replace `BED1` → `B1` |
| `PV1/PV1.3/PL.4/HD.1` | `PV1/PV1.3/PL.4/HD.1` | Constant: `HOSP_B` |
| `PV1/PV1.7/XCN.3` | `PV1/PV1.7/XCN.3` | Constant: `A` (middle initial) |

All other fields (patient name, DOB, gender, phone, SSN, timestamps, etc.) are mapped directly without transformation.

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
- Verify `schemas/` directory contains `ADT_A01.xsd`, `segments.xsd`, `fields.xsd`, and `datatypes.xsd`
- Check that all schemas use namespace `urn:hl7-org:v2xml`
- Ensure paths are relative to the route file location (`../schemas/ADT_A01.xsd`)

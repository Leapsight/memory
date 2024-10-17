# memory
An OTP library with a single module called `memory` that provides utilities for 
working with memory size units in both decimal (SI) and binary (IEC) formats.

It allows conversions between different units of measurement such as bytes,
kilobytes, megabytes, and their binary counterparts (kibibytes, mebibytes,
etc.), and formatting memory sizes in human-readable strings.

The main functionalities include:

- Converting between units (e.g., kilobytes to bytes, mebibytes to bytes)
- Formatting a memory size into human-readable strings in either decimal or
 binary units
- Providing an easy API for common memory unit conversions

The module supports both decimal and binary units:

- **Decimal units**: byte, kilobyte, megabyte, gigabyte, terabyte
- **Binary units**: byte, kibibyte, mebibyte, gibibyte, tebibyte

# Changelog

# 2.2.2

Improved error handling, documentation, and made the parser use `dynamic` instead of `Map<String, dynamic>` for the JSON object.

# 2.2.1

Changed types for ListProperty.function and MapProperty.function to make this usable as parsers on their own. 

# 2.2.0

Added support for default values using `.withDefault`

# 2.1.3

Improved documentation

# 2.1.2

Improved API reference by privating some internal methods and classes

# 2.1.1

Fixed documentation

# 2.1.0

- Added support for parsing enums
- Improved error handling

# 2.0.1

Fixed documentation mistake

# 2.0.0

- Removed need for registering types
- Only parsing what you need from the JSON rather than passing the whole JSON object into a constructor and parsing it there

## 1.0.1

Improved documentation

## 1.0.0

Initial version
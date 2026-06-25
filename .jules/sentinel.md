## 2024-06-25 - Prevent DoS from Malformed Remote JSON
**Vulnerability:** Application crashes due to unhandled `TypeError` exceptions when parsing remote JSON payloads containing unexpected types or missing fields.
**Learning:** Dart's implicit dynamic typing in `jsonDecode` combined with unsafe casts like `as List` or `List.from()` on null/invalid fields can lead to immediate application crashes (DoS) when receiving tainted remote payloads.
**Prevention:** Always validate top-level dynamic JSON structures (`is List`), filter valid collection elements (`whereType<Map<String, dynamic>>()`), and use safe defaults/type checks inside factory constructors.

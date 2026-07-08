# moresult

[![Package Version](https://img.shields.io/hexpm/v/moresult)](https://hex.pm/packages/moresult)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/moresult/)

Ergonomic Result utilities for Gleam.

## Installation

Add `moresult` to your project:

```sh
gleam add moresult@1
```

## Quick Example

```gleam
import moresult

pub fn main() -> Nil {
  let res = Ok(42) |> moresult.is_ok_and(int.is_even) // True
}
```

Further documentation can be found at <https://hexdocs.pm/moresult>.


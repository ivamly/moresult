//// A collection of ergonomic utility functions for working with Result types.
////
//// Inspired by Rust's Result module, this package provides helpful combinators
//// and transformations to make error handling in Gleam more expressive and concise.

import gleam/list
import gleam/option.{type Option, None, Some}

/// Returns true if the result is Ok and the value inside of it matches a predicate.
pub fn is_ok_and(result: Result(a, e), predicate: fn(a) -> Bool) -> Bool {
  case result {
    Ok(value) -> {
      predicate(value)
    }
    Error(_) -> False
  }
}

/// Returns true if the result is Error and the value inside of it matches a predicate.
pub fn is_error_and(result: Result(a, e), predicate: fn(e) -> Bool) -> Bool {
  case result {
    Ok(_) -> False
    Error(error) -> {
      predicate(error)
    }
  }
}

/// Converts Result(a, e) into an Option(a) and converting the error to None, if any.
pub fn ok(result: Result(a, e)) -> Option(a) {
  case result {
    Ok(value) -> Some(value)
    Error(_) -> None
  }
}

/// Converts Result(a, e) into an Option(e) and discarding the success value, if any.
pub fn error(result: Result(a, e)) -> Option(e) {
  case result {
    Ok(_) -> None
    Error(error) -> Some(error)
  }
}

/// Returns the provided default (if Error), or applies a function to the contained value (if Ok).
/// Arguments passed to map_or are eagerly evaluated;
/// if you are passing the result of a function call, it is recommended to use map_or_else, which is lazily evaluated.
pub fn map_or(result: Result(a, e), default: b, fun: fn(a) -> b) -> b {
  case result {
    Ok(value) -> {
      fun(value)
    }
    Error(_) -> default
  }
}

/// Maps a Result(a, e) to a by applying fallback function default to a contained Error value,
/// or function fun to a contained Ok value.
pub fn map_or_else(
  result: Result(a, e),
  default: fn() -> b,
  fun: fn(a) -> b,
) -> b {
  case result {
    Ok(value) -> {
      fun(value)
    }
    Error(_) -> default()
  }
}

/// Returns second if the first is Ok, otherwise returns the Error value of first.
pub fn and(first: Result(a, e), second: Result(b, e)) -> Result(b, e) {
  case first {
    Ok(_) -> second
    Error(error) -> Error(error)
  }
}

/// Extracts the Error value from a result, evaluating the default function if the result is an Error.
pub fn lazy_unwrap_error(result: Result(a, e), default: fn() -> e) -> e {
  case result {
    Ok(_) -> default()
    Error(error) -> error
  }
}

/// Extracts from a list of Result all Error elements. All the Error elements extracts in order.
pub fn errors(results: List(Result(a, e))) -> List(e) {
  list.filter_map(results, fn(result) {
    case result {
      Error(e) -> Ok(e)
      Ok(value) -> Error(value)
    }
  })
}

/// Case analysis for the Result type. If the value is Ok, apply the first function; if it is Error, apply the second function.
pub fn either(
  result: Result(a, e),
  on_ok: fn(a) -> b,
  on_error: fn(e) -> b,
) -> b {
  case result {
    Ok(value) -> on_ok(value)
    Error(error) -> on_error(error)
  }
}

pub fn from_either(result: Result(a, a)) -> a {
  case result {
    Ok(value) -> value
    Error(value) -> value
  }
}

// Calls a function with contained value if Ok. Returns the original result.
pub fn inspect(result: Result(a, e), func: fn(a) -> Nil) {
  case result {
    Ok(value) -> func(value)
    _ -> Nil
  }
  result
}

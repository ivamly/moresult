import gleam/float
import gleam/int
import gleam/list
import gleam/option.{None, Some}
import gleam/order
import gleam/string
import gleeunit
import moresult

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn is_ok_and_test() {
  assert moresult.is_ok_and(Ok(2), fn(x) { x % 2 == 0 })
  assert !moresult.is_ok_and(Ok("hello"), fn(x) { string.contains(x, "world") })
  assert !moresult.is_ok_and(Error("error"), fn(x) {
    list.all(x, fn(x) { float.compare(x, 0.3) == order.Eq })
  })
}

pub fn is_error_and_test() {
  assert moresult.is_error_and(Error("nope"), fn(x) { string.contains(x, "no") })
  assert moresult.is_error_and(Error(500), fn(x) { 500 == x })
  assert !moresult.is_error_and(Error(400), fn(x) { 500 == x })
  assert !moresult.is_error_and(Ok("hello"), fn(x) { list.any(x, int.is_even) })
}

pub fn ok_test() {
  assert moresult.ok(Ok(1)) == Some(1)
  assert moresult.ok(Error("no")) == None
}

pub fn error_test() {
  assert moresult.error(Ok("value")) == None
  assert moresult.error(Error(0.1)) == Some(0.1)
}

pub fn map_or_test() {
  assert moresult.map_or(Ok(3), 33, fn(x) { x * 3 }) == 9
  assert moresult.map_or(Ok("hello"), 42, fn(x) { string.length(x) }) == 5
  assert moresult.map_or(Error(3.0), "i need this", fn(x) { int.to_string(x) })
    == "i need this"
}

pub fn map_or_else_test() {
  assert moresult.map_or_else(Ok(3), fn() { 33 }, fn(x) { x * 3 }) == 9
  assert moresult.map_or_else(Ok("hello"), fn() { 42 }, fn(x) {
      string.length(x)
    })
    == 5
  assert moresult.map_or_else(Error(3.0), fn() { "i need this" }, fn(x) {
      int.to_string(x)
    })
    == "i need this"
}

pub fn add_test() {
  assert moresult.and(Ok("first"), Ok(1)) == Ok(1)
  assert moresult.and(Ok("first"), Error(-1)) == Error(-1)
  assert moresult.and(Error(0), Ok([])) == Error(0)
  assert moresult.and(Error(0), Error(1)) == Error(0)
}

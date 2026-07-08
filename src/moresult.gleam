import gleam/option.{type Option, None, Some}

pub fn is_ok_and(result: Result(a, e), predicate: fn(a) -> Bool) -> Bool {
  case result {
    Ok(value) -> {
      predicate(value)
    }
    Error(_) -> False
  }
}

pub fn is_error_and(result: Result(a, e), predicate: fn(e) -> Bool) -> Bool {
  case result {
    Ok(_) -> False
    Error(error) -> {
      predicate(error)
    }
  }
}

pub fn ok(result: Result(a, e)) -> Option(a) {
  case result {
    Ok(value) -> Some(value)
    Error(_) -> None
  }
}

pub fn error(result: Result(a, e)) -> Option(e) {
  case result {
    Ok(_) -> None
    Error(error) -> Some(error)
  }
}

pub fn map_or(result: Result(a, e), default: b, fun: fn(a) -> b) -> b {
  case result {
    Ok(value) -> {
      fun(value)
    }
    Error(_) -> default
  }
}

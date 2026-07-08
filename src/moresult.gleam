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

use std::{error, fmt};

#[derive(Debug)]
pub enum ServerError {
    StrError(&'static str),
}

impl From<&'static str> for ServerError {
    fn from(err: &'static str) -> Self {
        ServerError::StrError(err)
    }
}

impl fmt::Display for ServerError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            ServerError::StrError(s) => write!(f, "{}", s),
        }
    }
}

impl error::Error for ServerError {
    fn description(&self) -> &str {
        match self {
            ServerError::StrError(s) => s,
        }
    }

    fn cause(&self) -> Option<&dyn error::Error> {
        None
    }
}

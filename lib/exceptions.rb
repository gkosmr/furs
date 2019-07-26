module Exceptions
  class Exception < StandardError; end
  class CannotVerifyTls < Exception; end
  class JwtDecodeError < Exception; end
  class JwtInvalidSignature < Exception; end
  class ResponseError < Exception; end
  class NotImplemented < Exception; end
end
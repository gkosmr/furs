module Exceptions
  class Exception < StandardError; end
  class InvalidConfiguration < Exception; end
  class CannotVerifyTls < Exception; end
  class JwtDecodeError < Exception; end
  class JwtInvalidCertificate < Exception; end
  class ResponseError < Exception; end
  class NotImplemented < Exception; end
  class InvalidData < Exception; end
end
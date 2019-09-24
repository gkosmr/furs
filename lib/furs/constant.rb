module Furs
	module Constant
		ALGORITHM = 'RS256'

		DECIMAL_REGEX = /\A-?\d+(?:\.\d{0,2})?\z/
		ALPHANUMERIC_REGEX = /\A[a-zA-Z0-9]+\z/
		HEXADECIMAL_REGEX = /\A[a-f0-9]+\z/
		DATE_REGEX = /\A\d{4}\-[0-1]\d\-[0-3]\d\z/
		DATE_TIME_REGEX = /\A\d{4}\-[0-1]\d\-[0-3]\dT[0-2]\d\:[0-5]\d\:[0-5]\d\z/
		UUID_REGEX = /\A[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}\z/

	end
end
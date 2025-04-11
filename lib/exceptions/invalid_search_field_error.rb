class InvalidSearchFieldError < StandardError
  def initialize(msg = "Invalid Search Field provided. Only available options are: 'email', 'full_name', 'id'")
    super(msg)
  end
end

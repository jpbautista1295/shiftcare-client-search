class InvalidRemoteUrlError < StandardError
  def initialize(msg = "Invalid Remote URL provided.")
    super(msg)
  end
end

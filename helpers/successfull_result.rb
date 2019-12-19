# frozen_string_literal: true

# returns whether the result was successful or a failure
class SuccessfullResult
  def failure?
    false
  end

  def [](_)
    nil
  end
end

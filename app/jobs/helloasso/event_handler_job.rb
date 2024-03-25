class Helloasso::EventHandlerJob < ApplicationJob
  def perform(helloasso_event)
    helloasso_event.handle
  end
end
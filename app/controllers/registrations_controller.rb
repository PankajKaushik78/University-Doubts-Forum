class RegistrationsController < Devise::RegistrationsController

    # Creating Assistant object if registered user is assistant
    def create
      super
      if resource.persisted?
        if resource.designation == "assistant"
          resource.create_assistant
        end
      end
    end
  
  end
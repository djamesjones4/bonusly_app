# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    description "Create a new user"

    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :user_type, Types::UserAuthType, required: true

    field :success, Boolean, null: false
    field :user_id, ID, null: true
    def resolve(args)
      begin
        UserService.create_new_user(first_name: args[:first_name], last_name: args[:last_name], email: args[:email], user_type: args[:user_type])
      rescue StandardError => e
        raise BadRequestError, "Could not create user"
      end
    end
  end
end

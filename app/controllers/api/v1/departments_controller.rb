# frozen_string_literal: true
module Api
  module V1
    class DepartmentsController < ApplicationController
      before_action :authorize_admin, only: %i[index]
      def index
        @departments = Department.order("created_at DESC")
        render json: {
          status: true,
          data: @departments
        }, status: :ok
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class HolidaysController < ApplicationController
      before_action :set_holiday, only: %i[destroy]

      def index
        holidays = Holiday.all
        render json: holidays
      end

      def create
        holiday = Holiday.build(holiday_params)
        if holiday.save
          render json: holiday, status: :created
        else
          render json: holiday.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @holiday.destroy
        head :no_content
      end

      private

      def set_holiday
        @holiday = Holiday.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Holiday not found" }, status: :not_found
      end

      def holiday_params
        params.require(:holiday).permit(:holiday_date, :description)
      end
    end
  end
end

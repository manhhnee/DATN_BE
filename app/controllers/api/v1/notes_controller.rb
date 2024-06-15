# frozen_string_literal: true
module Api
  module V1
    class NotesController < ApplicationController
      before_action :set_note, only: %i[show update destroy]
      before_action :authorize_user

      def index
        @notes = current_user.notes
        render json: { data: @notes }
      end

      def show
        render json: { data: @note }
      end

      def create
        @note = current_user.notes.build(note_params)
        if @note.save
          render json: @note, status: :created
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      def update
        if @note.update(note_params)
          render json: @note
        else
          render json: @note.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @note.destroy
        render json: { message: "Note successfully deleted" }, status: :ok
      rescue StandardError => e
        render json: { error: "Failed to delete Note: #{e.message}" }, status: :internal_server_error
      end

      private

      def set_note
        @note = current_user.notes.find_by(id: params[:id])
        render json: { error: "Note not found" }, status: :not_found if @note.nil?
      end

      def authorize_user
        render json: { error: "Unauthorized" }, status: :unauthorized unless current_user.id == params[:user_id].to_i
      end

      def note_params
        params.require(:note).permit(:title, :description, :label, :day)
      end
    end
  end
end

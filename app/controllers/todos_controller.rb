# frozen_string_literal: true

class TodosController < ApplicationController
  def index
    @pagy, @todos = pagy(Todo.order(:due_date), limit: 10)
    render :index
  end
end

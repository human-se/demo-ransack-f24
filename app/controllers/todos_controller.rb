# frozen_string_literal: true

class TodosController < ApplicationController
  def index
    @q = Todo.ransack(params[:q])
    @q.sorts = 'due_date asc' if @q.sorts.empty?
    @pagy, @todos = pagy(@q.result(distinct: true), limit: 10)
    render :index
  end
end

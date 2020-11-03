class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    expense = Expense.new(expense_params)
    expense.save!
    redirect_to expenses_url, notice: "経費「#{expense.name}」を登録しました．"
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :expense, :description)
  end
end

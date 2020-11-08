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
    @expense = Expense.find(params[:id])
  end

  def update
    expense = Expense.find(params[:id])
    expense.update!(expense_params)
    redirect_to expenses_url, notice: "タスク「#{expense.name}」を更新しました。"
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    redirect_to expenses_url, notice: "タスク「#{expense.name}」を削除しました。"
  end

  def create
    expense = Expense.new(expense_params)
    expense.save!
    redirect_to expenses_url, notice: "経費「#{expense.name}」を登録しました．"
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :expense, :paid_at, :description)
  end
end

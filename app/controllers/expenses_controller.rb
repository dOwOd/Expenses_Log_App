class ExpensesController < ApplicationController
  def index(search_date = Time.now)
    @expenses = Expense.where(paid_at: search_date.in_time_zone.all_month).order("expense DESC")
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
    
    if !expense.name.present?
      expense.name = "名称未設定"
    end 

    if !expense.expense.present?
      expense.expense = 0
    end

    if !expense.paid_at.present?
      expense.paid_at = Time.now
    end

    expense.update!(expense_params)
    redirect_to expenses_url, notice: "タスク「#{expense.name}」を更新しました。"
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    redirect_to expenses_url, notice: "タスク「#{expense.name}」を削除しました。"
  end

  def create
    @expense = Expense.new(expense_params)

    if !@expense.name.present?
      @expense.name = "名称未設定"
    end

    if @expense.expense == nil
      @expense.expense = 0
    end

    if @expense.paid_at == nil
      @expense.paid_at = Time.now
    end

    if @expense.save
      redirect_to expenses_url, notice: "経費「#{@expense.name}」を登録しました．"
    else
      render :new
    end
  end

  

  private

  def expense_params
    params.require(:expense).permit(:name, :expense, :paid_at, :description)
  end

end

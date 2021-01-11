require 'date'

class ExpensesController < ApplicationController
  skip_before_action :join_required, only: [:index]
  
  def index
    if params[:group_id] != nil
      session[:group_id] = params[:group_id]
    end

    if params[:select_date] == nil
      @search_date = Date.today
    elsif !params[:select_date].kind_of?(Date)
      @search_date = params[:select_date].to_date
    else
      @search_date = params[:select_date]
    end

    case params[:months]
    when 'prev'
      @search_date = @search_date.prev_month(1)
    when 'next'
      @search_date = @search_date.next_month(1)
    when 'home'
      @search_date = Date.today
    end
    @expenses = Expense.joins(:group_expenses).where(group_expenses:{group_id:current_group.id}).where(expenses:{paid_at:@search_date.in_time_zone.all_month}).order("expense DESC")
    @users = User.joins(:group_users).select("users.*, group_users.id AS group_users_id").where(group_users: {group_id: current_group.id}).order("user_id ASC")
    @setting_users = GroupUser.joins(:user_setting, :user, :group).where(group_id: current_group.id).order(group_user_id: "ASC")
    @setting_user = @setting_users.find_by(user_id: current_user.id)
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
      expense.expense =groups 0
    end

    if !expense.paid_at.present?
      expense.paid_at = Time.now
    end

    @expense = Expense.new(expense_params)

    if @expense.name.length > 30
      flash[:expense_alert] = '名前は30文字以内で入力してください。'
      redirect_to expenses_url
    else
      @expense.update!(expense_params)
      redirect_to expenses_url, notice: "経費「#{@expense.name}」を更新しました。"
    end
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    redirect_to expenses_url, notice: "経費「#{expense.name}」を削除しました。"
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

    if @expense.name.length > 30
      flash[:expense_alert] = '名前は30文字以内で入力してください。'
      redirect_to expenses_url
    elsif @expense.save
      redirect_to expenses_url, notice: "経費「#{@expense.name}」を登録しました．"
    else
      render :new
    end
  end

  def auto_complete
    suggest_expenses = Expense.joins(:group_expenses).select(:name).where("name LIKE?", "%" + params[:term] + "%").where(group_expenses:{group_id: current_group.id}).order(:name).distinct
    suggest_expenses = suggest_expenses.map(&:name) 
    render json: suggest_expenses.to_json 
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :expense, :paid_at, :description, :user_id,  group_ids: [] )
  end

  def group_params
    params.require(:group).permit(:id)
  end 

end

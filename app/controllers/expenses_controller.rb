require 'date'

class ExpensesController < ApplicationController
  include ApplicationHelper
  # skip_before_action :join_required, only: [:index]
  
  def index
    if params[:group_id] != nil
      session[:group_id] = params[:group_id]
    end

    if params[:select_date] == nil
      @selected_month = Date.today.beginning_of_month
    else
      if date_valid?(params[:select_date])
        @selected_month = Date.parse(params[:select_date])
      else
        @selected_month = Date.today.beginning_of_month
      end
    end    
    @last_month = @selected_month.prev_month(1)
    @next_month = @selected_month.next_month(1)

    @group = Group.find_by(friendly_url: current_group.friendly_url)
    @expenses = Expense.joins(:group_expenses).where(group_expenses:{group_id:current_group.id}).where(expenses:{paid_at: @selected_month.in_time_zone.all_month}).order("expense DESC")
    @users = User.joins(:group_users).select("users.*, group_users.id AS group_users_id").where(group_users: {group_id: current_group.id}).order("user_id ASC")
    @setting_users = GroupUser.joins(:user_setting, :user, :group).where(group_id: current_group.id).order(group_user_id: "ASC")
    @setting_user = @setting_users.find_by(user_id: current_user.id)
  end

  def show
    @expense = Expense.friendly.joins("LEFT OUTER JOIN users ON users.id = expenses.user_id").select("users.screen_name, expenses.*").find_by(expenses: { friendly_url: params[:id]})
  end

  def new
    @expense = Expense.new
  end

  def edit
    @expense = Expense.friendly.find(params[:id])
  end

  def update
    @expense = Expense.friendly.find(params[:id])
    if @expense.name.length > 30
      flash[:expense_alert] = '名前は30文字以内で入力してください。'
      redirect_to expenses_url
    else
      @expense.update!(expense_params)
      redirect_to expenses_url, notice: "経費「#{@expense.name}」を更新しました。"
    end
  end

  def destroy
    expense = Expense.friendly.find(params[:id])
    expense.destroy
    redirect_to expenses_url, notice: "経費「#{expense.name}」を削除しました。"
  end

  def create
    @expense = Expense.new(expense_params)
    
    friendly_url = ''
    # 重複のないfriendly_urlを生成するまでループ
    loop do
      friendly_url = generate_friendly_url
      if Expense.friendly.find_by(friendly_url: friendly_url) == nil
        break
      end
    end
    @expense.friendly_url = friendly_url

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
    params.require(:expense).permit(:id, :name, :expense, :paid_at, :description, :user_id,  group_ids: [] )
  end

  def group_params
    params.require(:group).permit(:id)
  end 

  # params[:select_date]が正しい日付かチェック
  def date_valid?(str)
    !! Date.parse(str) rescue false
  end
end

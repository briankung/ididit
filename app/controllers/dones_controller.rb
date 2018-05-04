class DonesController < ApplicationController
  before_action :set_done, only: [:show, :edit, :update, :destroy]
  before_action :param_is_date?

  def index
    return redirect_to search_path(q: params[:q]) if params[:q]
    return redirect_to(day_edit_path(Date.current))
  end

  def show
  end

  def edit
  end

  def create
    Done.transaction do
      Done.where(date: date_param).destroy_all

      @dones = Done.create(
        dones_params.each_line.map do |done|
          Hash[text: done.strip, date: date_param]
        end
      )
    end

    redirect_back(fallback_location: dones_path, notice: 'Dones successfully created.')
  end

  def update
    if done_params[:text].blank?
      @done.destroy
      redirect_back(fallback_location: dones_path, notice: 'Done was successfully deleted.')
      return
    end

    respond_to do |format|
      if @done.update(done_params)
        format.html { redirect_back(fallback_location: dones_path, notice: 'Done was successfully updated.') }
        format.json { render :show, status: :ok, location: @done }
      else
        format.html { render :edit }
        format.json { render json: @done.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @done.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: dones_path, notice: 'Done was successfully destroyed.') }
      format.json { head :no_content }
    end
  end

  private
    def set_done
      @done = Done.find(params[:id])
    end

    def dones_params
      params.require :dones
    end

    def date_param
      params.require :date
    end

    def done_params
      params.require(:done).permit(:text, :date)
    end

    def param_is_date?
      begin
        @param_is_date = !!Date.strptime(params[:q], DATE_FORMAT)
      rescue
        @param_is_date = false
      end
    end
end

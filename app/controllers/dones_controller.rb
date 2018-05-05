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
    @dones = []

    Done.transaction do
      previous_dones = Done.on_date(date_param)
      incoming_dones = dones_params.each_line.reject(&:blank?).map(&:strip)
      longer_index = [previous_dones.count, incoming_dones.count].max - 1

      (0..longer_index).each do |index|
        previous = previous_dones[index]
        incoming = incoming_dones[index]

        if previous && incoming
          previous.update text: incoming unless previous.text == incoming
          @dones << previous
        elsif previous && !incoming
          previous.destroy
        elsif !previous && incoming
          @dones << Done.create(text: incoming, date: date_param)
        else # if !previous && !incoming
          raise 'wtf'
        end
      end
    end

    respond_to do |format|
      format.html { redirect_back(fallback_location: dones_path, notice: 'Dones successfully created.') }
      format.json { render(json: @dones.to_json, status: :ok) }
    end
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
      params[:dones] || ''
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

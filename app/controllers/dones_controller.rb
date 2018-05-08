class DonesController < ApplicationController
  before_action :set_done, only: [:show, :edit, :update, :destroy]

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
      incoming_dones = dones_params
                         .each_line
                         .reject(&:blank?)
                         .map {|line| Done.new(date: date_param, text: line.strip) }
      longer_index = [previous_dones.count, incoming_dones.count].max - 1

      (0..longer_index).each do |index|
        previous = previous_dones[index]
        incoming = incoming_dones[index]

        if previous && incoming
          next if previous == incoming
          previous.update(text: incoming.text)
        elsif previous && !incoming
          previous.destroy
          next
        elsif !previous && incoming
          incoming.save
        else # if !previous && !incoming
          raise 'wtf'
        end
      end
    end

    respond_to do |format|
      format.html { redirect_back(fallback_location: dones_path, notice: 'Dones successfully created.') }
      format.json { render(json: Done.on_date(date_param), status: :ok) }
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

end

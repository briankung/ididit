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
    previous = Done.on_date(date_param)
    incoming = dones_params
                 .each_line
                 .reject(&:blank?)
                 .map {|line| Done.new(date: date_param, text: line.strip) }
    combined = zip_dones(previous, incoming)

    @dones = handle_dones(combined).reject(&:blank?)

    respond_to do |format|
      format.html { redirect_back(fallback_location: dones_path, notice: 'Dones successfully created.') }
      format.json { render(json: @dones, status: determine_status) }
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
    def handle_dones combined
      Done.transaction do
        combined.map do |(previous, incoming)|
          if previous && incoming
            previous.update(text: incoming.text) unless previous == incoming
            previous
          elsif previous && !incoming
            previous.destroy
            next # This will result in a #nil, hence handle_dones(combined).reject(&:blank?)
          elsif !previous && incoming
            incoming.tap(&:save)
          else # if !previous && !incoming
            raise 'wtf'
          end
        end
      end
    end

    def zip_dones previous, incoming
      # This method is necessary because Array#zip is limited by the length of
      # the method receiver, not by combined length.
      #     [1].zip([1,2]) #=> [[1,1]]
      #                        not [[1,1], [nil,2]]
      if previous.length >= incoming.length
        previous.zip(incoming)
      else
        # handle_dones needs previous dones to come first
        incoming.zip(previous).map(&:reverse)
      end
    end

    def determine_status
      it_was_updated, was_it_created = @dones.any?(&:text_previously_changed?), @dones.any?(&:id_previously_changed?)

      if it_was_updated then was_it_created ? :created : :ok else :no_content end
    end

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

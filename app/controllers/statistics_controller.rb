class StatisticsController < ApplicationController
  before_action :set_statistic, only: [:show, :edit, :update, :destroy]
  before_action :set_graph, except: :autocomplete

  # GET /statistics
  # GET /statistics.json
  def index
    if current_member.member?
      @statistics = Statistic.my_recent(Time.current_eow, @graph.id, current_member.id)
    else
      @statistics = Statistic.recent(Time.current_eow, @graph.id)
    end
  end

  # GET /statistics/1
  # GET /statistics/1.json
  def show
  end

  # GET /statistics/new
  def new
    attrs = {
      graph_id: @graph.id,
      organisation_id: current_member.organisation.id,
      added_by_id: current_member.id,
      week_ending_at: Time.current_eow
    }
    @statistic = Statistic.new(attrs)
  end

  # GET /statistics/1/edit
  def edit
  end

  # POST /statistics
  # POST /statistics.json
  def create
    @statistic = Statistic.new(statistic_params)

    respond_to do |format|
      if @statistic.save
        format.html { redirect_to new_statistic_path(graph_id: @graph.id), notice: 'Statistic was successfully created.' }
        format.json { render :show, status: :created, location: @statistic }
      else
        format.html { render :new }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statistics/1
  # PATCH/PUT /statistics/1.json
  def update
    respond_to do |format|
      if @statistic.update(statistic_params)
        format.html { redirect_to statistics_path(graph_id: @graph.id), notice: 'Statistic was successfully updated.' }
        format.json { render :show, status: :ok, location: @statistic }
      else
        format.html { render :edit }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistics/1
  # DELETE /statistics/1.json
  def destroy
    @statistic.destroy
    respond_to do |format|
      format.html { redirect_to statistics_url(graph_id: @graph.id), notice: 'Statistic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graph
      g_id = if params[:statistic]
        statistic_params[:graph_id]
      elsif params[:graph_id]
        params[:graph_id]
      end
      @graph = Graph.find(g_id)
    end

    def set_statistic
      @statistic = Statistic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def statistic_params
      params.require(:statistic).permit(:organisation_id, :graph_id, :added_by_id, :week_ending_at, :value, :currency, :fact_column_1, :fact_column_2, :fact_column_3, :fact_column_4)
    end
end

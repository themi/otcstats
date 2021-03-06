class GraphsController < ApplicationController
  before_action :set_organisation
  before_action :set_graph, only: [:show, :edit, :update, :destroy]

  # GET /graphs
  # GET /graphs.json
  def index
    @graphs = @organisation.graphs.all
  end

  # GET /graphs/1
  # GET /graphs/1.json
  def show
  end

  # GET /graphs/new
  def new
    @graph = @organisation.graphs.new
  end

  # GET /graphs/1/edit
  def edit
  end

  # POST /graphs
  # POST /graphs.json
  def create
    @graph = @organisation.graphs.new(graph_params)

    respond_to do |format|
      if @graph.save
        format.html { redirect_to @graph, notice: 'Graph was successfully created.' }
        format.json { render :show, status: :created, location: @graph }
      else
        format.html { render :new }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graphs/1
  # PATCH/PUT /graphs/1.json
  def update
    respond_to do |format|
      if @graph.update(graph_params)
        format.html { redirect_to @graph, notice: 'Graph was successfully updated.' }
        format.json { render :show, status: :ok, location: @graph }
      else
        format.html { render :edit }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graphs/1
  # DELETE /graphs/1.json
  def destroy
    @graph.destroy
    respond_to do |format|
      format.html { redirect_to graphs_url, notice: 'Graph was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /graphs/report
  def report
    prepare_for_export
  end

  # GET /graphs/csv
  def csv
    prepare_for_export
    @envisage_csv = ExportStatistics.envisage_csv(@eow, @graphs)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graph
      @graph = @organisation.graphs.find(params[:id])
    end

    def set_organisation
      org_id = params[:organisation_id] || current_member.organisation.id
      @organisation = Organisation.find(org_id)
    end

    def prepare_for_export
      @graphs =  Graph.active_graphs_for(@organisation)
      @eow = Time.current_eow
      CurrencyConverter.new.perform
    end

    # Only allow a list of trusted parameters through.
    def graph_params
      params.require(:graph).permit(:organisation_id, :name, :item_number, :short_name, :definition, :value_title, :field_titles, :envisage_key)
    end
end

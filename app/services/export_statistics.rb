require 'csv'

class ExportStatistics
  class << self
    def envisage_csv(eow=nil, graphs=nil)
      build_envisage_csv(eow, graphs)
    end

    # def envisage(eow=nil, graphs=nil)
    #   build_envisage_packet(eow, graphs)
    # end

    private

    def build_envisage_csv(eow=nil, graphs=nil)
      all_graphs = graphs || Graph.active_graphs
      eow ||= Time.current_eow

      CSV.generate do |csv|
        csv << ["Graph ID", "Graph Name", eow.strftime("%Y-%B-%-d")]
        all_graphs.each do |graph|
          total = Statistic.total_stats(eow, graph.id)
          csv << [graph.envisage_key, eval_envisage_name(graph), total]
        end
      end
    end

    def eval_envisage_name(graph)
      if graph.envisage_name
        buffer = graph.envisage_name.gsub("${<item_number>}", graph.item_number.to_s.rjust(2, '0'))
        buffer.gsub("${<organisation>}", graph.organisation.to_s)
      end
    end

    # def build_envisage_packet(eow=nil, graphs=nil)
    #   all_graphs ||= Graph.normal.to_a + Graph.restricted.to_a
    #   eow ||= Time.current_eow

    #   data_points = []
    #   all_graphs.each do |graph|
    #     data_points << {
    #       graph_id: graph.envisage_key,
    #       value: Statistic.total_stats(eow, graph.id)
    #     }
    #   end

    #   {
    #     period: eow.strftime("%Y-%m-%d"),
    #     data_points: data_points
    #   }
    # end

  end
end

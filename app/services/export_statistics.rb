require 'csv'

class ExportStatistics
  class << self
    def envisage_csv(eow=nil, graphs=nil)
      build_envisage_csv(eow, graphs)
    end

    def envisage(eow=nil, graphs=nil)
      build_envisage_packet(eow, graphs)
    end

    private

    def build_envisage_packet(eow=nil, graphs=nil)
      all_graphs ||= Graph.normal.to_a + Graph.restricted.to_a
      eow ||= Time.current_eow

      data_points = []
      all_graphs.each do |graph|
        buffer = Statistic.recent(eow, graph.id)
        data_points << {
          graph_id: graph.envisage_key,
          value: buffer.sum(:value)
        }
      end

      {
        period: eow.strftime("%Y-%m-%d"),
        data_points: data_points
      }
    end

    def build_envisage_csv(eow=nil, graphs=nil)
      all_graphs ||= Graph.normal.to_a + Graph.restricted.to_a
      eow ||= Time.current_eow

      CSV.generate do |csv|
        csv << ["Graph ID", "Graph Name", eow.strftime("%Y-%B-%-d")]
        all_graphs.each do |graph|
          buffer = Statistic.recent(eow, graph.id)
          csv << [graph.envisage_key, eval_envisage_name(graph), buffer.sum(:value)]
        end
      end
    end

    def eval_envisage_name(graph)
      buffer = graph.envisage_name.gsub("${<item_number>}", graph.item_number.to_s.rjust(2, '0'))
      buffer = buffer.gsub("${<organisation>}", graph.organisation.to_s)
      buffer
    end
  end
end

class ExportStatistics

  def envisage
    build_envisage_csv
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
        row << [graph.envisage_key, graph.envisage_name, buffer.sum(:value)]
      end
    end
  end

end

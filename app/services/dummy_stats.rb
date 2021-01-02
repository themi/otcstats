class DummyStats
  attr_reader :eow

  def initialize(eow)
    @eow = eow
  end

  def perform
    10.times.each do |ndx|
      member = Member.all.sample
      add_dummy_stats_for(member)
    end
    # Attendance
    attendance(member)
  end

  private

  def add_dummy_stats_for(member)
    # Bridge Steps
    rand(5).times.each { bridge_steps(member) }
    # Books
    books(member)
    # Aliance Donations
    rand(5).times.each { alliance_dono(member) }
    # Volunteer Hours
    rand(5).times.each { v_hours(member) }
    # IAS Donations
    rand(5).times.each { ias_dono(member) }
    # Events
  end

  def bridge_steps(member)
    graph = Graph.where(short_name: "Bridge Steps").first
    attribs = {
      fact_column_1: FFaker::Name.first_name,
      fact_column_2: dummy_service,
      fact_column_3: dummy_org,
      fact_column_4: member.full_name,
      value: 1,
      week_ending_at: eow,
      added_by_id: member.id,
      graph_id: graph.id,
      organisation_id: member.organisation_id
    }
    Statistic.create(attribs)
  end

  def books(member)
    graph = Graph.where(short_name: "Books Sold").first
    attribs = {
      value: 1 + rand(50),
      week_ending_at: eow,
      added_by_id: member.id,
      graph_id: graph.id,
      organisation_id: member.organisation_id
    }
    Statistic.create(attribs)
  end

  def alliance_dono(member)
    graph = Graph.where(short_name: "Alliance Funds Raised").first
    attribs = {
      fact_column_1: FFaker::Name.first_name,
      fact_column_2: dummy_org,
      fact_column_3: member.full_name,
      value: 100 + rand(5000),
      currency: ["AUD", "USD"].sample,
      week_ending_at: eow,
      added_by_id: member.id,
      graph_id: graph.id,
      organisation_id: member.organisation_id
    }
    Statistic.create(attribs)
  end

  def v_hours(member)
    graph = Graph.where(short_name: "Volunteer Hours").first
    arr = v_hours_data(member)
    attribs = {
      fact_column_1: arr[0],
      fact_column_2: arr[1],
      value: 1 + rand(10),
      week_ending_at: eow,
      added_by_id: member.id,
      graph_id: graph.id,
      organisation_id: member.organisation_id
    }
    Statistic.create(attribs)
  end

  def attendance(member)
    graph = Graph.where(short_name: "Bridge Steps").first
    attribs = {
      value: 10 + rand(10),
      week_ending_at: eow,
      added_by_id: member.id,
      graph_id: graph.id,
      organisation_id: member.organisation_id
    }
    Statistic.create(attribs)
  end

  def ias_dono(member)
    graph = Graph.where(short_name: "IAS").first
    attribs = {
      fact_column_1: FFaker::Name.first_name,
      fact_column_2: member.full_name,
      value: 100 + rand(5000),
      currency: "USD",
      week_ending_at: eow,
      added_by_id: member.id,
      graph_id: graph.id,
      organisation_id: member.organisation_id
    }
    Statistic.create(attribs)
  end


  def dummy_service
    FFaker::HipsterIpsum.word
  end

  def dummy_org
    FFaker::AddressAU.suburb
  end

  def v_hours_data(member)
    if [0,1].sample == 1
      ["Post", member.full_name]
    else
      [FFaker::HipsterIpsum.word, [FFaker::Name.first_name, member.full_name].sample]
    end
  end

end

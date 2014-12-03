class PackagerDashboardCell < Cell::Rails

  def show(args)
    @jobs_summary = {:in_progress => 5, :error => 2, :complete => 7}
    @popular = {:geminabox => 134, :httpd => 12, :nginx => 99}
    render
  end

end

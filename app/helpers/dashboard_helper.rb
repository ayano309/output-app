module DashboardHelper
  def way_color(articles)
    articles_count = articles.count
    if articles_count == 0
      return 'level1'
    elsif articles_count == 1
      return 'level2'
    elsif articles_count == 2
      return 'level3'
    elsif articles_count >= 3
      return 'level4'
    end
  end
end

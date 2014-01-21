module SeoHelper

  def title str = nil
    content_for :title, str or default_title
  end

  def default_title
    'NonSoS'
  end

end
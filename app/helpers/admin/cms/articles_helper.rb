module Admin::Cms::ArticlesHelper

  def article_status(article)
    h = {
        "published" => "success",
        "removed" => "important",
        "pending" => "warning",
        "draft" => "info"
    }

    "<span class='label label-#{h[article.status]}'>#{article.status}</span>".html_safe
  end

end

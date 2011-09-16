class Adminful < AbstractController
  R.add '/admin', 'Adminful#dashboard', :name => 'admin'
  # Dashboard for admin actions
  def dashboard
    @title = 'Admin'
    render 'admin/dashboard', :layout => 'layouts/main', :cachable => true
  end


  R.add '/admin/clear_views', 'Adminful#clear_hardcache', :type => 'post'
  # Clears the view/hard cache
  def clear_hardcache
    HardCache.clear
    redirect_to 'Adminful#dashboard', :flash => 'Cleared view cache'
  end


  R.add '/admin/clear_templates', 'Adminful#clear_all_caches', :type => 'post'
  # Clears the template chache
  def clear_all_caches
    TemplateCache.clear
    HardCache.clear
    redirect_to 'Adminful#dashboard', :flash => 'Cleared template and view cache'
  end
end


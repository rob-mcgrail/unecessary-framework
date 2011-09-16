require 'test/unit'

class RendererTest < Test::Unit::TestCase

  def setup
    @backup = {}
    @backup[:view_folder] = SETTINGS[:view_folder]
    @backup[:app_layout] = SETTINGS[:app_layout]

    SETTINGS[:view_folder] = '/test/core/'
    SETTINGS[:app_layout] = 'fixtures/main'
  end

  def teardown
    SETTINGS[:view_folder] = @backup[:view_folder]
    SETTINGS[:app_layout] = @backup[:app_layout]
  end

  def test_partial_renders_template
    assert_equal "<p></p>\n", AbstractController.new.partial('fixtures/template')
  end


  def test_render_renders_template
    assert_equal "<body>\n<p></p>\n\n</body>\n",
                  AbstractController.new.render('fixtures/template')[:body]
  end


  def test_render_renders_template_with_layout
    assert_equal "<body>\n<div>\n<p></p>\n\n</div>\n\n</body>\n",
                  AbstractController.new.render('fixtures/template', :layout => 'fixtures/layout')[:body]
  end


  def test_render_takes_response_codes
    assert_equal '200', AbstractController.new.render('fixtures/template')[:code]
    assert_equal '404', AbstractController.new.render('fixtures/template', :code => '404')[:code]
  end


  def test_render_takes_content_types
    assert_equal 'text/html', AbstractController.new.render('fixtures/template')[:type]['Content-Type']
    assert_equal 'xml', AbstractController.new.render('fixtures/template', :type => 'xml')[:type]['Content-Type']
  end

end


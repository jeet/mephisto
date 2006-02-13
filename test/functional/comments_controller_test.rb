require File.dirname(__FILE__) + '/../test_helper'
require_dependency 'comments_controller'

# Re-raise errors caught by the controller.
class CommentsController; def rescue_action(e) raise e end; end

class CommentsControllerTest < Test::Unit::TestCase
  fixtures :contents, :attachments

  def setup
    @controller = CommentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_routing
    self.with_options :year => '2006', :month => '01', :day => '01', :permalink => 'foo' do |test|
      test.assert_routing '2006/01/01/foo',         :controller => 'mephisto', :action => 'show'
      test.assert_routing '2006/01/01/foo/comment', :controller => 'comments', :action => 'create'
    end
  end

  def test_should_add_comment
    assert_difference Comment, :count do
      assert_difference contents(:welcome), :comments_count do
        post :create, contents(:welcome).hash_for_permalink.merge(:comment => {
          :body   => 'test comment', 
          :author => 'bob'
        })
        assert_redirected_to @controller.url_for(contents(:welcome).hash_for_permalink(:controller => 'mephisto', 
                                                                                       :action     => 'show', 
                                                                                       :anchor     => "comment_#{assigns(:comment).id}"))
        contents(:welcome).reload
      end
    end
  end

  def test_should_show_article_page_on_invalid_comment
    assert_no_difference Comment, :count do
      assert_no_difference contents(:welcome), :comments_count do
        post :create, contents(:welcome).hash_for_permalink.merge(:comment => {
          :body => 'test comment'
        })
        assert_response :success
        contents(:welcome).reload
      end
    end
  end

  def test_should_reject_missing_article_params
    get :create
    assert_redirected_to @controller.send(:category_url, { :categories => [] })
    post :create, :year => '2006', :month => '01', :day => '01', :permalink => 'foo'
    assert_redirected_to @controller.send(:category_url, { :categories => [] })
  end

  def test_should_reject_get_request
    get :create, contents(:welcome).hash_for_permalink
    assert_redirected_to @controller.url_for(contents(:welcome).hash_for_permalink(:controller => 'mephisto', 
                                                                                   :action     => 'show'))
  end

  def test_should_reject_invalid_post
    post :create, contents(:welcome).hash_for_permalink
    assert_redirected_to @controller.url_for(contents(:welcome).hash_for_permalink(:controller => 'mephisto', 
                                                                                   :action     => 'show'))
  end
end

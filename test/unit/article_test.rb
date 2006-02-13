require File.dirname(__FILE__) + '/../test_helper'

class ArticleTest < Test::Unit::TestCase
  fixtures :contents

  def test_should_create_permalink
    a = Article.create :title => 'This IS a Tripped out title!!!1  (well not really)', :body => 'foo', :user_id => 1
    assert_equal 'this_is_a_tripped_out_title_1_well_not_really', a.permalink
  end

  def test_full_permalink
    date = 3.days.ago
    assert_equal ['', date.year, date.month, date.day, 'welcome_to_mephisto'].join('/'), contents(:welcome).full_permalink
  end

  def test_should_show_published_status
    assert contents(:welcome).published?
    assert contents(:future).published?
    assert !contents(:unpublished).published?
  end

  def test_should_show_pending_status
    assert !contents(:welcome).pending?
    assert contents(:future).pending?
    assert !contents(:unpublished).pending?
  end

  def test_should_show_status
    assert_equal :published,   contents(:welcome).status
    assert_equal :pending,     contents(:future).status
    assert_equal :unpublished, contents(:unpublished).status
  end

  def test_should_cache_redcloth
    a = Article.create :title => 'This IS a Tripped out title!!!1  (well not really)', :user_id => 1, :excerpt => '*foo*', :body => '_bar_'
    assert_equal '<p><strong>foo</strong></p>', a.excerpt_html
    assert_equal '<p><em>bar</em></p>',         a.body_html
  end
end

require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < Test::Unit::TestCase
  fixtures :contents

  def test_sti_associations
    assert_equal contents(:welcome), contents(:welcome_comment).article
    assert_equal [contents(:welcome_comment)], contents(:welcome).comments
  end

  def test_add_comment
    assert_difference Comment, :count do
      assert_difference contents(:welcome), :comments_count do
        contents(:welcome).comments.create :body => 'test comment', :author => 'bob', :author_ip => '127.0.0.1'
        contents(:welcome).reload
      end
    end
  end

  def test_add_comment
    c = contents(:welcome).comments.create :body => '*test* comment', :author => 'bob', :author_ip => '127.0.0.1'
    assert_equal "<p><strong>test</strong> comment</p>", c.body_html
  end

  def test_should_return_correct_author_link
    assert_equal 'rico',                            contents(:welcome_comment).author_link
    contents(:welcome_comment).author_url = 'abc'
    assert_equal %Q{<a href="http://abc">rico</a>}, contents(:welcome_comment).author_link
    contents(:welcome_comment).author_url = 'https://abc'
    assert_equal %Q{<a href="https://abc">rico</a>}, contents(:welcome_comment).author_link
  end
end

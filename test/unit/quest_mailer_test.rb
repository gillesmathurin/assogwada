require File.dirname(__FILE__) + '/../test_helper'

class QuestMailerTest < ActionMailer::TestCase
  tests QuestMailer
  def test_sent
    @expected.subject = 'QuestMailer#sent'
    @expected.body    = read_fixture('sent')
    @expected.date    = Time.now

    assert_equal @expected.encoded, QuestMailer.create_sent(@expected.date).encoded
  end

end

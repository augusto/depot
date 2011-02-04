require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    order = orders(:one)
    mail = Notifier.order_received(order)
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal [order.email], mail.to
    assert_equal ["test@augustorodriguez.com.ar"], mail.from
  end

  test "order_shipped" do
    mail = Notifier.order_shipped
    assert_equal "Order shipped", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["test@augustorodriguez.com.ar"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

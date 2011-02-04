require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    order = orders(:one)
    mail = Notifier.order_received(order)
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal [order.email], mail.to
    assert_equal ["test@augustorodriguez.com.ar"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "order_shipped" do
    order = orders(:one)
    mail = Notifier.order_shipped(order)
    assert_equal "Pragmatic Order Shipped", mail.subject
    assert_equal [order.email], mail.to
    assert_equal ["test@augustorodriguez.com.ar"], mail.from
    assert_match /Programming Ruby 1.9/, mail.body.encoded
  end

end

require 'fluent/test'
require 'fluent/plugin/filter_json_merge'

Fluent::Test.setup

class JsonMergeTest < Test::Unit::TestCase
  setup do
    @tag = 'docker.container'
  end

  def create_driver(conf, use_v1_config = true)
    Fluent::Test::OutputTestDriver.new(Fluent::JsonMergeFilter, @tag).configure(conf, use_v1_config)
  end

  sub_test_case 'configure' do
    test 'check_default' do
      d = create_driver('')

      assert_equal 'log', d.instance.key
      assert_true d.instance.remove
    end

    test 'override_key' do
      d = create_driver(%[key not_log])

      assert_equal 'not_log', d.instance.key
      assert_true d.instance.remove
    end

    test 'override_remove' do
      d = create_driver(%[remove false])

      assert_equal 'log', d.instance.key
      assert_false d.instance.remove
    end

    test 'override_both' do
      d = create_driver(%[
                        key random
                        remove false
      ])

      assert_equal 'random', d.instance.key
      assert_false d.instance.remove
    end
  end

  sub_test_case 'filter' do
    test 'missing_key' do
      record = { 'key' => 'value' }


      d = create_driver('')
      result = d.instance.filter('tag', 'time', record)

      assert_equal record, result
    end

    test 'happy_path' do
      record   = { 'key' => 'value', 'log' => '{ "msg": "message" }' }
      expected = { 'key' => 'value', 'msg' => 'message' }

      d = create_driver('')
      result = d.instance.filter('tag', 'time', record)

      assert_equal expected, result
    end

    test 'no_delete' do
      record   = { 'key' => 'value', 'log' => '{ "msg": "message" }' }
      expected = { 'key' => 'value', 'log' => '{ "msg": "message" }', 'msg' => 'message' }

      d = create_driver(%[remove false])
      result = d.instance.filter('tag', 'time', record)

      assert_equal expected, result
    end
  end
end

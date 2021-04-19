# frozen_string_literal: true

module LinkedListHelper
  def extract_path_positions(path_list)
    path_list.map { |path| _extract_positions_from_node(path) }.flatten
  end

  private

  def _extract_positions_from_node(node)
    arr = []
    while node
      arr.append(node.position)
      node = node.next
    end
    arr
  end
end

RSpec.configure do |config|
  config.include LinkedListHelper
end

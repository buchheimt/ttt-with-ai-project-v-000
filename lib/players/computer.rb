module Players

  class Computer < Player

    def move(board)
       token == "O" ? opponent_token = "X" : opponent_token = "O"

      if board.valid_move?("5")
      # check for center
        move_index = 4
      elsif next_move(2, token)
      # check for chance to win
        move_index = get_move_index(next_move(2, token))
      elsif next_move(2, opponent_token)
      # check for opponent chance to win
        move_index = get_move_index(next_move(2, opponent_token))
      elsif next_move(1, token, true)
      # check for second combo spot in a corner
        move_index = get_move_index_even(next_move(1, token, true))
      elsif next_move(1, token)
      # check for second combo spot anywhere
        move_index = get_move_index(next_move(1, token))
      elsif get_move_index_even((0..8))
      # check for first available corner
        move_index = get_move_index_even((0..8))
      else
      # place in first available space anywhere
        move_index = get_move_index((0..8))
      end
      "#{move_index + 1}"
    end

    def next_move(goal_count, token, even_check = false)
      Game::WIN_COMBINATIONS.detect do |combo|
        combo_values = combo.map {|i| board.cells[i]}
        count = combo_values.count {|cell| cell == token}
        if count == goal_count && no_opponent_cells(combo_values, token)
          even_check ? get_move_index_even(combo) : get_move_index(combo)
        end
      end
    end

    def get_move_index(combo)
      combo.detect {|index| board.valid_move?("#{index + 1}")}
    end

    def get_move_index_even(combo)
      combo.detect {|index| board.valid_move?("#{index + 1}") && index.even?}
    end

    def no_opponent_cells(combo_values, token)
      combo_values.all? {|value| value == token || value == " "}
    end

  end
end

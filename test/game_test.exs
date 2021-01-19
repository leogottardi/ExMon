defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Player, Game}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Leonardo", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Leonardo", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robo"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Leonardo"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Leonardo", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robo"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Leonardo"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 30,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robo"
        },
        player: %Player{
          life: 12,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Leonardo"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns info player" do
      player = Player.build("Leonardo", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Leonardo"
      }

      assert Game.player() == expected_response
    end
  end

  describe "turn/0" do
    test "returns info turn" do
      player = Player.build("Leonardo", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      Game.start(computer, player)

      assert Game.turn() == :player
    end
  end

  describe "fetch_player/0" do
    test "returns info turn" do
      player = Player.build("Leonardo", :chute, :soco, :cura)
      computer = Player.build("Robo", :chute, :soco, :cura)

      Game.start(computer, player)

      assert Game.fetch_player(:player) == player
    end
  end
end
